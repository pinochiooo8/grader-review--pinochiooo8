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

java -cp ".:/path/to/junit.jar:/path/to/other/dependencies" org.junit.runner.JUnitCore $(basename $TEST_FILE_NAME .java)

if [ $? -eq 0 ]; then
    echo "All tests passed. Great job!"
else
    echo "Some tests failed. Please review the test output above for details."
fi

