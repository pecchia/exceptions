#include <cstdlib>
#include <csignal>
#include <exception>
#include <iostream>
#include <vector>
#include "errorcodes.h"

extern "C"{
  void testsub1(double *, int *, double *);
  void teststop(void);
  void testfpe(void);
  void testioerror(void);
  void testalloc(void);
}

extern "C"{
  void throw_exception_(const int& errcode)
  {
     std::cout<<"throw_exception"<<std::endl;
     throw errcode;
  }
}

void signalHandler(int signum)
{
   std::cout << std::endl;
   switch(signum)
   {
     case SIGSEGV:  
       std::cout << "SEGMENTATION FAULT ERROR" << std::endl;
       break;
     case SIGINT:
       std::cout << "INTERRUPT ERROR" << std::endl;
       break;
     case SIGFPE:   
       std::cout << "FLOATING POINT EXCEPTION" << std::endl;
       break;
     default:  
       std::cout << "INTERRUPT ERROR code n. "<< signum << std::endl;
   }
   exit(signum);
}

void exitHandler(void)
{
   std::cout << "code exit "<<std::endl;
   exit(0);
}

void exceptionHandler(int e)
{
    switch(e)
    {
      case _ERR_FILE_ERR:
        std::cout << "Exeption file error "<< e << std::endl;
        break;
      case _ERR_ALLOC_ERR:
        std::cout << "Exeption allocation error "<< e << std::endl;
        break;
      default:
        std::cout << "Exeption error code "<< e << std::endl;
    }
}

void tests(char ch)
{
    std::vector<double> vec;
    double av;
    int n;

    switch(ch)
    {
      case 'S':
        // catch a stop in fortran
        teststop();
        break;
      case 'E':
        // make a deliberate SEGFAULT exception
        n=10; 
        testsub1(&vec[0],&n,&av);
        std::cout<<"av: "<<av<<std::endl;
        break;
      case 'I':
        // file I/O error
        testioerror();
        break;
      case 'F':
        // integer floating point error
        testfpe();
        break;
      case 'A':
        // allocation error
        testalloc();
        break;
    }
}

int main(int argc, char *argv[])
{
  if (argc < 2){
    std::cout << "main S|E|F|I|A"<< std::endl;
    return 0;
  }

  // capture stop statments
  std::atexit(exitHandler);

  // register signals 
  signal(SIGINT, signalHandler);
  signal(SIGSEGV, signalHandler);
  signal(SIGTERM, signalHandler);
  signal(SIGABRT, signalHandler);
  signal(SIGFPE, signalHandler);
  signal(SIGILL, signalHandler);
 
  // try-catch to capture exceptions 
  try{
    tests(argv[1][0]);
  }
  catch (int e)
  {
    exceptionHandler(e);
  }

}

