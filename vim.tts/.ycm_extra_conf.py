import os

flags = [
    '-Wall',
    #'-Werror',
    #'-Wno-long-long',
    #'-Wno-unused-variable',
    #'-Wno-variadic-macros',
    '-fexceptions',
    '-DNDEBUG',
    '-std=c++11',
    '-x', 'c++',
    '-I', '.',
    '-isystem', '/usr/include',
    '-isystem', '/usr/local/include',
    '-isystem', '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1',
]

SOURCE_EXTENSIONS = ['.cpp', '.cxx', '.cc', '.c', '.m', '.mm']

def DirectoryOfThisScript():
    return os.path.dirname(os.path.abspath(__file__))

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)

    return new_flags

def FlagsForFile(filename, **kwargs):
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute(flags, relative_to)
    return {'flags': final_flags, 'do_cache': True}

# EOF
