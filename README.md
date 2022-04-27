# ProjectKineti
# Setup and Installation Guide for Robotframework: 
1. Install Pycharm Free edition
2. Install latest python ( Check the option for Adding python to PATH)
3. To check for version of python on cmd : python --version
4. To check for version of pip on cmd : pip --version
5. Install robotframework using command : pip install robotframework
6. Install Selenium library using command : pip install robotframework-seleniumlibrary
7. Install Chromedriver chromedriver.exe and add it to the path
8. Install Project interpreters such as selenium, robotframework and robotframework-selenium in Pycharm Settings
9. Install Packages IntellibotSelenium plugins in Pycharm

# Test Setup
1. Folder KinetiKeywords:
This folder contain some files that initiate all of page elements, also their action as objects.
2. Folder Testcases :
This folder contain some files that test cases executed.

# Running Testcases to view result:
Create a Directory 'Results' to save results

  # To run all the 5 testcases at once
  From your Terminal, go to the project directory
  Run the test cases using the following command : 
  robot -d Results KinetiTestcases/Testcases.robot 

  # To run single testcase
  From your Terminal, go to the project directory
  Run the test cases using the following command : 
  robot -d Results KinetiTestcases/Testcases/Testcase 1.a.robot

