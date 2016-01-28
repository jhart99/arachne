FROM vogt1005.scripps.edu:5000/hadoop

ADD files/namenode /usr/local/bin

# Expose ports we need.  In order they are:
# fs.default.name
# dfs.namenode.servicerpc-address
# dfs.http.address
# dfs.https.address (secure)
EXPOSE 9000 8020 8022 50070 50470
