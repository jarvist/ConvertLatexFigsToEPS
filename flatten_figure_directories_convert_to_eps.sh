# First find all graphics presently used
grep includegraphics *.tex | cut -f2- -d{ | tr -d {} > figlist.tmp
# - odd cut / tr commands are to escape if {{}} sets of quotes are used (for figure filenames with '.'s)

for figure in ` cat figlist.tmp `
do
    ext="${figure##*.}"
    echo $ext

    flatfile=` echo "${figure}" | sed -e "s/\//_/g" -e "s/\./_/g" `
#    echo "${figure} --> ${flatfile}"

    case $ext in
    "png")
        echo PNG! 
        # nb: convert with eps3 == highly compressed (lossless) level 3 postscript
        convert "${figure}" eps3:${flatfile/_png/.eps}
    ;;
    "eps")
        echo "EPS!"
        cp -a "${figure}" "${flatfile/_eps/.eps}"
    ;;
    *)
        echo "What on earth is extension ${ext}?"
        echo "Cowardly refusing to convert"
    ;;
    esac

done
