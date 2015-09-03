cmake_minimum_required(VERSION 2.8)

# Options about components
# All are enabled by default
option(LUA_BUILD_LUAI "Also build the lua interpreter" ON)
option(LUA_BUILD_LUAC "Also build the lua compiler" OFF)

project(lua C)

# Configuration for luaconf.h

# Default values
option(LUA_32BITS "Use 32 bit integers and floats." OFF )
option(LUA_COMPAT_5_2 "Compatibility with Lua 5.2 sources" OFF)
option(LUA_COMPAT_5_1 "Compatibility with Lua 5.1 sources" OFF)

# Generate luaconf.h
configure_file(src/luaconf.h.in ${CMAKE_CURRENT_BINARY_DIR}/luaconf.h)

# Targets
set(LUA_RUNTIME_OUTPUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE}"
    CACHE STRING "Lua executable output directory"
)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

set(SRC_CORE
    src/lapi.c
    src/lcode.c
    src/lctype.c
    src/ldebug.c
    src/ldo.c
    src/ldump.c
    src/lfunc.c
    src/lgc.c
    src/llex.c
    src/lmem.c
    src/lobject.c
    src/lopcodes.c
    src/lparser.c
    src/lstate.c
    src/lstring.c
    src/ltable.c
    src/ltm.c
    src/lundump.c
    src/lvm.c
    src/lzio.c
)

set(SRC_LIB
    src/lauxlib.c
    src/lbaselib.c
    src/lbitlib.c
    src/lcorolib.c
    src/ldblib.c
    src/liolib.c
    src/lmathlib.c
    src/loslib.c
    src/lstrlib.c
    src/ltablib.c
    src/linit.c
    src/loadlib.c
    src/lutf8lib.c
)

set(SRC_LUAI
    src/lua.c
)

set(SRC_LUAC
    src/lua.c
)

add_library(liblua STATIC
    ${SRC_CORE} ${SRC_LIB}
)

set(LUA_LINK_DIR
    ${CMAKE_CURRENT_BINARY_DIR}
    CACHE STRING "Lua link path"
)

set(LUA_LIB
    liblua
    CACHE STRING "Lua library"
)

set_target_properties(liblua PROPERTIES FOLDER ThirdParty)

if (LUA_BUILD_LUAI)
    link_directories(${LUA_LINK_DIR})
    add_executable(lua ${SRC_LUAI} src/lua.rc)
    target_link_libraries(lua ${LUA_LIB})
    set_target_properties(lua
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${LUA_RUNTIME_OUTPUT_DIR}
    )
    set_target_properties(lua PROPERTIES FOLDER ThirdParty)
endif()

if (LUA_BUILD_LUAC)
    link_directories(${LUA_LINK_DIR})
    add_executable(luac ${SRC_LUAC} src/luac.rc)
    target_link_libraries(luac ${LUA_LIB})
    set_target_properties(luac
        PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${LUA_RUNTIME_OUTPUT_DIR}
    )
    set_target_properties(luac PROPERTIES FOLDER ThirdParty)
endif()

set(LUA_INCLUDE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    CACHE STRING "Lua include path"
)
