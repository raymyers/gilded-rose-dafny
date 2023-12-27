default: gilded.jar

gilded.jar: gilded.dfy
	dafny build gilded.dfy -t java

out.txt: FORCE
	java -jar gilded.jar > out.txt

test: gilded.jar out.txt
	diff out.txt golden.txt

clean: 
	rm *.jar

FORCE: ;
