echo "Generating tree diagrams..."

#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-tcp-client\@*.yang > ietf-tcp-client-tree.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-tcp-server\@*.yang > ietf-tcp-server-tree.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-tcp-common\@*.yang > ietf-tcp-common-tree.txt

#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-tcp-common\@*.yang > ietf-tcp-common-tree-no-expand.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-tcp-client\@*.yang > ietf-tcp-client-tree-no-expand.txt
#pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-tcp-server\@*.yang > ietf-tcp-server-tree-no-expand.txt

extract_grouping_with_params() {
  # $1 name of module
  # $2 name of grouping
  # $3 addition CLI params
  # $4 output filename
  pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings $3 ../$1@*.yang > $1-groupings-tree.txt
  cat $1-groupings-tree.txt | sed -n "/^  grouping $2/,/^  grouping/p" > tmp
  c=$(grep -c "^  grouping" tmp)
  if [ "$c" -ne "1" ]; then
    ghead -n -1 tmp > $4
    rm tmp
  else
    mv tmp $4
  fi
}

extract_grouping() {
  # $1 name of module
  # $2 name of groupin
  #extract_grouping_with_params "$1" "$2" "" "tree-$2.expanded.txt"
  extract_grouping_with_params "$1" "$2" "--tree-no-expand-uses" "tree-$2.no-expand.txt"
}

extract_grouping ietf-tcp-common tcp-common-grouping
extract_grouping ietf-tcp-client tcp-client-grouping
extract_grouping ietf-tcp-server tcp-server-grouping

