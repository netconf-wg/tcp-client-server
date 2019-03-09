
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-tcp-client\@*.yang > ietf-tcp-client-tree.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-tcp-server\@*.yang > ietf-tcp-server-tree.txt

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-tcp-client\@*.yang > ietf-tcp-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-tcp-server\@*.yang > ietf-tcp-server-tree-no-expand.txt

