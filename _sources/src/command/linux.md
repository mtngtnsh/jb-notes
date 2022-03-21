# Linux

## know about info of linux server

```sh
$ cat /etc/os-release
$ cat /etc/redhat-release
```

## find

```sh
$ find {target_directory} -name {target_file} -type f -print0 | xargs -0 grep {keyword}
```

e.g

```sh
# 1. current directory: find 'hoge' with 'foo*'(file)
$ find . -name 'foo*' -type f -print0 | xargs -0 grep {keyword}

# 2. current directory: find 'hoge' with the '.txt' extension files
$ find . -name '*.txt' -print0 | xargs -0 grep {keyword}

# 3. /var/log: find 'hoge'
$ find /var/log -type f -print0 | xargs -0 grep {keyword}
```

## cat

```sh
$ cat [-belnstuv] [file ...]
```

::: {tip}

```
DESCRIPTION
     The cat utility reads files sequentially, writing them to the standard output.  The file operands are
     processed in command-line order.  If file is a single dash (‘-’) or absent, cat reads from the standard
     input.  If file is a UNIX domain socket, cat connects to it and then reads it until EOF.  This complements
     the UNIX domain binding capability available in inetd(8).

     The options are as follows:

     -b      Number the non-blank output lines, starting at 1.

     -e      Display non-printing characters (see the -v option), and display a dollar sign (‘$’) at the end of
             each line.

     -l      Set an exclusive advisory lock on the standard output file descriptor.  This lock is set using
             fcntl(2) with the F_SETLKW command.  If the output file is already locked, cat will block until the
             lock is acquired.

     -n      Number the output lines, starting at 1.

     -s      Squeeze multiple adjacent empty lines, causing the output to be single spaced.

     -t      Display non-printing characters (see the -v option), and display tab characters as ‘^I’.

     -u      Disable output buffering.

     -v      Display non-printing characters so they are visible.  Control characters print as ‘^X’ for control-
             X; the delete character (octal 0177) prints as ‘^?’.  Non-ASCII characters (with the high bit set)
             are printed as ‘M-’ (for meta) followed by the character for the low 7 bits.
```

:::

## zip

### Encryption

- for example

```sh
$ zip -e -r {name_filedir}.zip {dir}/
```

::: {tip}
```
Encryption:  
  -e        use standard (weak) PKZip 2.0 encryption, prompt for password  
  -P pswd   use standard encryption, password is pswd

Recursion:  
  -r        recurse paths, include files in subdirs:  zip -r a path path ...  
  -R        recurse current dir and match patterns:   zip -R a ptn ptn ...  
  Use -i and -x with either to include or exclude paths  
  Path root in archive starts at current dir, so if /a/b/c/file and  
   current dir is /a/b, 'zip -r archive .' puts c/file in archive
```

:::
