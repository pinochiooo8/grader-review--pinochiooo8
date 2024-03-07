CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ -f "student-submission/ListExamples.java" ]; then
  echo "file found"
else
  echo "file ListExamples.java not found"
  exit 1
fi 

cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area/

cd grading-area
javac -cp $CPATH *.java

if [ $? -ne 0 ]; then
    echo "Compilation error. Please check your submission for errors."
    exit 1
fi


java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples

