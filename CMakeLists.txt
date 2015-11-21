cmake_minimum_required(VERSION 3.0)

string(COMPARE NOTEQUAL "$ENV{TRAVIS_TAG}" "" travis_deploy)
string(COMPARE EQUAL "$ENV{APPVEYOR_REPO_TAG}" "true" appveyor_deploy)

if(travis_deploy)
  set(version "$ENV{TRAVIS_TAG}")
elseif(appveyor_deploy)
  set(version "$ENV{APPVEYOR_REPO_TAG_NAME}")
else()
  set(version "v0.0.0")
endif()

string(REGEX REPLACE "^v" "" version "${version}")

project(Foo VERSION ${version})

add_library(foo foo.cpp)
add_executable(boo foo.cpp)

install(TARGETS foo DESTINATION lib)
install(TARGETS boo DESTINATION bin)

set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

if(travis_deploy OR appveyor_deploy)
  string(COMPARE EQUAL "$ENV{CONFIG}" "Debug" debug_build)
  if(debug_build)
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}-Debug")
  else()
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}")
  endif()
endif()

include(CPack)
