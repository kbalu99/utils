ng build --prod --build-optimizer
git init
git commit -m "final commit"
git push -u origin master
ng build --prod --base-href https://kbalu99.github.io/<proj-name>/
ngh --dir dist/<proj-name>