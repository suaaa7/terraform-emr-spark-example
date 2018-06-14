[
   {
      "classification":"zeppelin-env",
      "properties":{

      },
      "configurations":[
         {
            "classification":"export",
            "properties":{
               "ZEPPELIN_MEM":"\"-Xms1024m -Xmx8192m -XX:MaxPermSize=1024m\"",
               "ZEPPELIN_SSL_KEYSTORE_PASSWORD":"${zeppelin_keystore_password}",
               "ZEPPELIN_SSL_KEY_MANAGER_PASSWORD":"${zeppelin_keystore_password}",
               "ZEPPELIN_SSL":"true",
               "ZEPPELIN_SSL_PORT":"${zeppelin_port}",
               "ZEPPELIN_NOTEBOOK_STORAGE":"org.apache.zeppelin.notebook.repo.S3NotebookRepo",
               "ZEPPELIN_NOTEBOOK_S3_BUCKET":"${zeppelin_notebook_s3_bucket}",
               "ZEPPELIN_NOTEBOOK_S3_USER":"zeppelin"
            },
            "configurations":[

            ]
         }
      ]
   },
   {
      "classification": "yarn-env",
      "properties": {

      },
      "configurations": [
         {
            "classification": "export",
            "properties": {
               "YARN_RESOURCEMANAGER_OPTS": "-Dhadoop.root.logger=DEBUG"
            },
            "configurations": [

            ]
         }
      ]
   }
]
