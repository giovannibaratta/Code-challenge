# Cerca tutti i file con estensione .yml in modo ricorsivo partendo
# dalla cartella passata come argomento ($1). Per ignorare dei file
# o delle cartelle aggiungerli ai file .fdignore

DIR_TO_SCAN="$1"

if [ "$DIR_TO_SCAN" == "" ]
then
    echo "Directory not specified."
    exit 1
fi

CURRENT_DIRECTORY=$( pwd )
cd "$DIR_TO_SCAN"
# fd usa di default i file .fdignore e .gitignore per ignorare i file
fd --max-depth 15 --type file --extension yml --hidden --absolute-path
