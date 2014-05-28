#!/bin/bash
#
#   Mongo Tool Script
#
#   @author : Thierry Lagasse "KRKN"
#   @since : 25 mar 2014
#   @license : UNLICENSE

DB_NAME='your-mongo-db'
DB_COLLECTIONS=( 'your-documents' 'another' )
DATAS_PATH='./_datas'
DATAS_OUTPUT=''
DATAS_INPUT=''

VERSION='0.1.0'

# =============================================================================

mongo_export()
{
    echo -e "\nExport \"${DB_NAME}\" collections in ${DATAS_PATH}"

    [ ! -d $DATAS_PATH ] && mkdir -p $DATAS_PATH || :

    pushd ${DATAS_PATH} > /dev/null
    for COLLECTION in "${DB_COLLECTIONS[@]}" ; do
        echo -e "\n---- ${COLLECTION} ----"
        #rm -f ${COLLECTION}.mongo.json
        mongoexport -d ${DB_NAME} -c ${COLLECTION} -o ${COLLECTION}.mongo.json
    done
    popd > /dev/null
}

# -----------------------------------------------------------------------------

mongo_import()
{
    echo -e "\nImport \"${DB_NAME}\" collections"

    if [ ! -d $DATAS_PATH ] ; then
        echo "Invalid path : ${DATAS_PATH}"
        exit 1
    fi

    pushd ${DATAS_PATH} > /dev/null
    for COLLECTION in "${DB_COLLECTIONS[@]}" ; do
        echo -e "\n---- ${COLLECTION} ----"

        if [ -f ${COLLECTION}.mongo.json ] ; then
            mongoimport --upsert -d ${DB_NAME} -c ${COLLECTION} --file ${COLLECTION}.mongo.json
        else
            echo "No collection file : ${COLLECTION}.mongo.json"
        fi
    done
    popd > /dev/null
}

# -----------------------------------------------------------------------------

show_help()
{
    echo -e "---- Mongo Tools ----\n"
    echo -e "$0 [-h]\n\tDisplay this usage message.\n"
    echo -e "$0 [-v | --version]\n\tDisplay script version.\n"
    echo -e "$0 [-o] (actions list)\n\tExecute each action :"
    echo -e "\t\texport: export database collection in JSON"
    echo -e "\t\timport: import collection from JSON"
    echo -e "\t\tclear: remove all collections from database"
    echo -e "\nExample: $0 export clear import :"
    echo -e "\tExport collections, then clear DB and finally re-import !"
    echo ""
}

show_version()
{
    echo -e "---- Mongo Tools ----\nVersion: ${VERSION}"
}

test_json()
{
    read -r -p "Bash JSON parser not installed. Install now ? [y/N]} " RESPONSE
    case $RESPONSE in
        [yY][eE][sS]|[yY])
            npm install -s JSON.sh
            ;;
        *)
            echo -en "Abor t!"
            exit 1
            ;;
    esac
}

# -----------------------------------------------------------------------------
PARAMS=$@
ACTIONS=()

if [ -z "${PARAMS}" ] ; then PARAMS='-h' ; fi
for PARAM in $PARAMS; do
    if [ -z "$PARAM_NEXT" ] ; then
        case $PARAM in
            -h | --help | \? )
                show_help
                exit 0
                ;;

            -v | --version )
                show_version
                exit 0
                ;;

            -o | --output )
                PARAM_NEXT="--output"
                ;;

            -i | --input )
                PARAM_NEXT="--input"
                ;;

            export | import | clear )
                ACTIONS+=(${PARAM})
        esac
    else
        case $PARAM_NEXT in
            --output )
                DATAS_OUTPUT="/${PARAM}"
            ;;

            --input )
                DATAS_INPUT="/${PARAM}"
            ;;
        esac

        unset PARAM_NEXT
    fi
done

# -----------------------------------------------------------------------------

for ACTION in "${ACTIONS[@]}" ; do
    case $ACTION in
        export )
            mongo_export
            ;;

        import )
            mongo_import
            ;;

        clear )
            echo -e "Clear all \"${DB_NAME}\" collections"
            mongo $DB_NAME --eval "db.dropDatabase()" > /dev/null
            ;;
    esac
done
exit 0
