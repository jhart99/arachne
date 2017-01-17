import web
import xml.etree.ElementTree as ET

tree = ET.parse('servers.xml')
root = tree.getroot()

urls = (
        '/ipxeman/', 'list_hosts',
        '/ipxeman/hostname-(.*)\.ipxe', 'get_hostname',
        '/ipxeman/set', 'set',
        '/ipxeman/boot.ipxe', 'boot',
        '/ipxeman/boot.ipxe.cfg', 'boot_cfg'
        )

app = web.application(urls, globals())

class list_hosts:
    def GET(self):
        output = 'hosts:[';
        for child in root:
            print 'host', child.tag, child.attrib
            output += str(child.attrib) + ','
        output += ']';
        return output

class get_hostname:
    def GET(self, user):
        for child in root:
            if child.attrib['hostname'] == user:
                output = "#!ipxe\nset menu-default %s\n" % (str(child.attrib["default"]))
                with open(child.attrib['menu'], 'rb') as menu:
                    for line in menu.readlines():
                        output += line
                return output
        output = ""
        with open('menu.ipxe', 'rb') as menu:
            for line in menu.readlines():
                output += line
        return output
 
class set:
    def GET(self):
        in_data = web.input()
        for child in root:
            if child.attrib['hostname'] == in_data.hostname:
                child.attrib['default'] = in_data.default
                child.set('updated', 'yes')
                tree.write('servers.xml')
class boot:
    def GET(self):
        output = ""
        with open('boot.ipxe', 'rb') as menu:
            for line in menu.readlines():
                output += line
        return output
class boot_cfg:
    def GET(self):
        output = ""
        with open('boot.ipxe.cfg', 'rb') as menu:
            for line in menu.readlines():
                output += line
        return output
if __name__ == "__main__":
    app.run()
