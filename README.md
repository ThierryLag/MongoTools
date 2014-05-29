# MongoTools

> **Warning !** Work in progress. This package isn't ready for production.

MongoTools is a little shell script that provide command line interface to
manage Mongo documents.

These features are based on Mongo command line tools : mongoexport, mongoimport, ...  
With a simple command, you can :

* **Import** documents from JSON file
* **Export** documents to JSON file
* **Clean** documents by removing the content  

Use this script directly in you shell or add it to grunt or git-hooks.

## Installation

You can install "MongoTools" globally : 

    npm install -g mongotools

Or locally : 

    npm install mongotools --save-dev
    ln -s node_modules/.bin/mongotools .

_This second line create a symbolic link in your application root directory for MongoTools shell script._

## Settings

You can pass parameters to script (see below).

Otherwise the script try to find information from `package.json` of your app. 

    "mongotools": {
        "db": "dbname",
        "collections": [
            "documents",
            "you",
            "want",
            "export/import/clear"
        ],
        "path": "./_datas/"
    }

_But, you can override these parametres via command line._

## Usage

@TODO
        
## License

BashTools is free and unencumbered public domain software.  
For more information, see <http://unlicense.org/> or the accompanying LICENSE file.

