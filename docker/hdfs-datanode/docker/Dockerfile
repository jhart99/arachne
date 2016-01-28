FROM vogt1005.scripps.edu:5000/hadoop

ADD files/datanode /usr/local/bin

# Expose ports which we need in order they are:
# dfs.datanode.address
# dfs.datanode.address (secure)
# dfs.datanode.http.address
# dfs.datanode.https.address
# dfs.datanode.http.address (secure)
# dfs.datanode.ipc.address

# if you change the ports in the xml, you will need to update them here as well
EXPOSE 50010 1004 50075 50475 1006 50020
