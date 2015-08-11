cmake_minimum_required(VERSION 2.8)
project(Foo)

add_library(foo foo.cpp)
add_executable(boo foo.cpp)

install(TARGETS foo DESTINATION lib)
install(TARGETS boo DESTINATION bin)

string(COMPARE NOTEQUAL "$ENV{TRAVIS_TAG}" "" travis_deploy)
if(travis_deploy)
  string(REGEX REPLACE "^v([0-9]+)\\.[0-9]+\\.[0-9]+$" "\\1" major_ver "$ENV{TRAVIS_TAG}")
  string(REGEX REPLACE "^v[0-9]+\\.([0-9]+)\\.[0-9]+$" "\\1" minor_ver "$ENV{TRAVIS_TAG}")
  string(REGEX REPLACE "^v[0-9]+\\.[0-9]+\\.([0-9]+)$" "\\1" patch_ver "$ENV{TRAVIS_TAG}")
else()
  set(major_ver 0)
  set(minor_ver 0)
  set(patch_ver 0)
endif()

set(CPACK_PACKAGE_VERSION_MAJOR ${major_ver})
set(CPACK_PACKAGE_VERSION_MINOR ${minor_ver})
set(CPACK_PACKAGE_VERSION_PATCH ${patch_ver})

if(travis_deploy)
  string(COMPARE EQUAL "$ENV{CONFIG}" "Debug" debug_build)
  if(debug_build)
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}-Debug")
  else()
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-$ENV{TOOLCHAIN}")
  endif()
endif()

include(CPack)
