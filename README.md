# MongoTools

MongoTools is a little shell script that provide command line interface to
manage Mongo documents.

With a simple command, you can import, export, clean a Mongo database.

You can use this script directly in you shell or add it to grunt or git-hooks.

## Installation

You can clone the repo or directly download the script at :

    @TODO : add github URL to raw script.

## Settings

Edit the variables below at the beginning of the script :

* `DB_NAME='your-mongo-db'` : name of you mongo database
* `DB_COLLECTIONS=( 'your-documents' 'another' )` : array of documents to import/export/clear
* `DATAS_PATH='./_datas'` : path where the script store the datas.

## Usage

* Export Mongo document :

        ./mongotools.sh export

* Display this usage message :
        ./mongotools.sh [-h]

* Display script version :

        ./mongotools.sh [-v | --version]

* Make actions on MongoDB :

        ./mongotools.sh [-o] (actions list)

    Execute each action :
        export: export database collection in JSON
        import: import collection from JSON
        clear: remove all collections from database

    Example: `./mongotools.sh export clear import` :
        Export collections, then clear DB and finally re-import !

## License

BashTools is free and unencumbered public domain software.
For more information, see <http://unlicense.org/> or the accompanying LICENSE file.

