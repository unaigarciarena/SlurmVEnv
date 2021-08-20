rm nodelist.sh
echo "good='" >> nodelist.sh
find . -maxdepth 1 -name "*nodo*" -print | sed -n -e 's/.\///p' | sed -n -e 's/.out.*$//p' | paste -s -d\  - >> nodelist.sh
echo "'

all='" >> nodelist.sh
sinfo -N | grep 2018 | sed -n -e 's/ .*//p' |paste -s -d\  - >> nodelist.sh
echo "'

echo '--exclude= '\${all[@]} \${good[@]} | tr ' ' '\n' | sort | uniq -u | paste -s -d," >> nodelist.sh

