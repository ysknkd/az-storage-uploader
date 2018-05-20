# az-storage-uploader

Multiple files upload to Azure Blob Storage.

## Prerequisite

* Azure CLI 2.x or above.

Please export the your Azure Account.

```
$ export AZURE_STORAGE_ACCOUNT=<storage_account_name
$ export AZURE_STORAGE_ACCESS_KEY=<storage_account_key>
```

or

```
$ export AZURE_STORAGE_CONNECTION_STRING="<connection_string>"
```

Official document here. https://docs.microsoft.com/azure/storage/common/storage-azure-cli

## Usage

```console
$ ./az-storage-uploader.sh <path_to_directory> <container_name>
```

e.g.

```console
$ tree ./test
./test
├── sub_dir
│   └── sub_testfile
└── testfile
```

```console
$ ./az-storage-uploader.sh ./test container
Exists Azure Storage Account

Uploading ... 'sub_dir/sub_testfile'
Finished[#############################################################]  100.0000%
{
  "etag": "...",
  "lastModified": "..."
}

Uploading ... 'testfile'
Finished[#############################################################]  100.0000%
{
  "etag": "...",
  "lastModified": "..."
}
```

