# Un<!-- badges: start -->
[![R build status](https://github.com/IainMcl/R-Unit-Testing/workflows/R-CMD-check/badge.svg)](https://github.com/IainMcl/R-Unit-Testing/actions)
<!-- badges: end -->

Unit testing in R

There are two main ways to run unit tests in R. One of these if within an R Package and the other is to just
test functions. 

For this demonstration you will use the functionality provided in [`testthat`](https://r-pkgs.org/tests.html). This can be installed like with any
package using ```install.packages("testthat")```.

- [Testing an R package](#testing-an-r-package)
- [Testing a directory](#testing-a-directory) 
- [Writing Tests](#writing-tests)
- [Possible issues](#possible-issues)

## Testing an R package

For instructions on how to setup an R package following the instructions [here](https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html) is a good start.
From this guide there are a few dependancies:
- devtools - *for package related functions*
- roxygen - *to generate documentation (optional)*

On top of this when working within a package it is easier to add tests and set up a test directory using `usethis`.
- usethis 

cd into your package where all of your R scripts should be contained with in a sub directory called `R`. Making use
of `usethis` you can set up our test directory structure. 
```
usethis::use_testthat()
```

This will create a new folter called `tests` which will contain the file `testthat.R` and the directory `testthat`.
All of your test code will be contained within the `testthat` dir. 

### Adding tests 

From within your `R` folder open a file containing the code that you wish to test open the file and run 
```
use_test()
```
If you recieve the error: `Error in use_test() : could not find function "use_test"` you need to import the `usethis`
library, `library(usethis)`.

Running the `use_test()` command will automatically create a new file within `./tests/testthat/` with the name of 
the form `test-<FILE_NAME>.R`. Although you haven't writen any tests yet you can now run the example test that has been 
created in this file. 

### Running tests

You can run tests by calling the command 
```
devtools::test()
```
This will test all of the `testthat` functions you have currently writen.

In the base example you have the following that is generated automatically. Here `test_that` makes use of the 
`expect_equal` function to check that 2x2 = 4. 
```
test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
```

you can see that this passes as when running `devtools::test()` the results come back as 1 OK and 0 Failed.

If you edit the above function to 
```
expect_equal(2 * 2, 5)
```
and re-run our tests you get a failure message along with a summary of what has failed.

Until now you haven't actually tested the function that you wanted to test. It is time to change our test 
function to check the functionality you actually want. Since you are using an R package you can just call the 
function as you would normaly due to the library import or the package in the `testthat.R` file. In the example 
in `./PackageTest/R/add_function.R` there is a function that takes two inputs and returns the sum. You can test 
this in `./PackageTest/tests/testthat/test-add_function.R` for example using
```
test_that("Test the add function for two integers", {
  expect_equal(add(2, 4), 6)
})
```

### Note

Note: due to the way that R packages usually work this method of `use_test()` to create tests this will not work
in folders with sub-directories `./R/<SUB-DIR>`. This can be seen in the folder `./R/SubFolder/`.

## Testing a directory

Not all R code is writen within an R package, however, these tools apear to mainly have been developed with working 
in a package in mind. Therefore setting up your tests is a little less straigh forward but you can still use some 
of the tools used when working within a package.

To keep your code clean storing your source code within an `R` folder and tests in a `tests` folder makes sense.
You will need to make these folders manually and keep a track of new files and test coverage by yourself.
Below is an example of making these files and directories. To keep convention you may wish to use the same names
as if you were working in a package however these can be anything that you like.
```
mkdir R tests
cd tests
mkdir testthat
touch testthat.R
```
Inside the file `testthat.R` is where we can add the code to run all of the tests. Since this is just a normal
R file you can add any other code in here that you want to be run for each test.
Again to replicate what would be in a package we can use `testthat::test_dir()` to run all tests that are contained
witin the `testthat` directory. An example of a `testthat.R` file that would do this could be
```
library(testthat)

testthat::test_dir(path="tests/testthat", reporter = "summary")
```
**Note**: Since this is not a package you will need to choose where you will be running your tests from. With 
the path shown it is assumed you will be running from the project root directory i.e. the one containing the `R` 
and `tests` folders. Use `getwd()` to find which directory you are currently in.

Running the file `testthat.R` will run all of the files within `./tests/testthat` that start `test-<FILE NAME>`.
This can be seen as there are two files in `./tests/testthat`, `file.R` and `test-file.R`. When you run the file 
`./tests/testthat.R` you will see that only one of the files has been run; the one starting `test-`. 

Here we have chosen to use `reporter = "summary"` within the `test_dir` call. This gives a bit more detal on 
what tests have failed. There are other options such as "minimal" which will give green and red dots signifying
if a test has passed or failed giving a cleaner if not less informative output.

In the `R` directory again we have the file `add_function.R`. To be able to access this file within our test 
directory it will need to be sourced to access the files contents. Adding a file called `test-add_function.R` add
```
source("./../../R/add_function", chdir = TRUE) 
```
This line of sourcing goes up to `tests`, up to `PackageTest`, then into `R`, and can access the file. Setting `chrid = TRUE` allows for the file to be sourced relative to the file where the source is being called. Without `chdir = TRUE` the run directory can be a little more complicated.

## Writing Tests

To better understand which tests are being run a `context(<str:TESTS-DESCTIPTION>)` which describes the tests that are going to be run in the file.

Depending on your program structure you should think about how you want your test to be layed out. It is often a good
idea to have your tests follow the same structure as your source code. This means that it could be a good idea to have
one test file per source file. Obveously if your files are very large and contain a lot of functionality it may be 
better to split the test files to cover specific sections of each file. In this case using `use_test` as described may
need to be suplimented with more test files. In this case using `use_test("<NAME>")` a new test file will be created in 
`./tests/testthat` called `test-<NAME>.R` ready to edit.

### Expect statments

There are many different `expect` statments that can be used in `testthat`. To see the possibilities in R Studio, in
the console type `expect_` and a list of possible auto-fills should pop up. If this dosen't happen or you click away
hit `CTRL+SPACE` to bring up the autofill suggestions. Some of the most common statments include

```
expect_equal(object, expected) # Tests that an object returns the expected value
expect_gt(object, expected) # Check that the object produeces and output greather than the expected value
expect_error(object) # Check that the code throws an error
```

A full list with documentation can be found in the `testthat` package documentation.

### Writing `test_that` functions

TODO

## Possible issues

### Conflict warnings

```
Warning message:

-- Conflicts ------------------------------------------ PackageTest conflicts --
x add() masks PackageTest::add()

Did you accidentally source a file rather than using `load_all()`?
Run `rm(list = c("add"))` to remove the conflicts. 
```
Having an uncleaned environment can result in conflicts. If this occurs just clean the environment and run again.

### Could not find function `use_test`

```Error in use_test() : could not find function "use_test"```
Importing the `usethis` library, `library(usethis)` will alow the use of the `use_test` function.

### Not inside a package

```
> devtools::test()
Error: Could not find package root, is your working directory inside a package?
```
As the name suggests if you are not in a package you can't use `devtools::test()`. If you want to work in a package 
using the instructions [here](https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html)
may be useful. If you are intending on not working in a package the following the instructions [above](#testing-a-directory).
