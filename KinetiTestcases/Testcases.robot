*** Settings ***
Resource    C:/Users/nisha/PycharmProjects/ProjectKineti/KinetiTestcases/KinetiKeywords.robot

*** Test Cases ***
Testcase 1.a
    SampleDataTable
    TableParsed
    Find Different Items Sold in the Office Supply

Testcase 1.b
    SampleDataTable
    TableParsed
    Find Item sold Less than 5 units

Testcase 1.c
    SampleDataTable
    TableParsed
    Find if Pencil sold less than 5 units

Testcase 1.d
    SampleDataTable
    TableParsed
    Find Expensive Item

Testcase 2
    SampleDataTableDownload
    LinkToDownloadFound
    Download Excel