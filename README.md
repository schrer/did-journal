# did.sh
 
A simple script to keep a journal of your daily accomplishments and done tasks.
Inspired by [Patricks article about a did.txt file](https://theptrk.com/2018/07/11/did-txt-file/).
 
The script outputs text to a file, using markdown formatting, so it works well with e.g.  [Nextcloud Notes](https://apps.nextcloud.com/apps/notes).
For each day a new section gets added to the top of the file and new entries get appended at the end of the current days section, so more current days are at the top of the file.
 
## Installation

**Requirements:**

* pcregrep
* sed
* a command line editor of your choosing

Download the script and put it in a folder where it suits you and make it executable with `chmod +x did.sh`. I use a folder named *~/.userdefined_scripts* for storing my own scripts.
Then add an alias for the script in your shell.

	alias did="/path/to/script/did.sh"

Before using it you should also edit it to use an editor you like (default is `nano`) and set the path where the journal should be saved.
There are two variables for that at the beginning of the script.

Also, if you want to edit the formatting of the output, keep in mind that you probably need to change the regular expression that matches the current block of entries.
If you only change the pattern of the timestamps (the format with which `date` is called) this should not be necessary.

## Usage
```
did [OPTION|ENTRY]
	
  Call either with an option, a journal entry to save or no further input.
  No input wil open the journal in an editor in the terminal.
  Giving some string will insert the string into the journal as a new entry.
	
Options:
	-e	open the script itself in an editor to edit it
```

Example:
```
did "write README.md for did.sh"
```
This adds the entry to my did.txt.
Calling `did` without parameters opens up the did.txt, which now looks like this:
```
# 20.07.2018
[12:16:46] add support for album adding and access rights manipulation to the LycheeUploader
[20:23:02] write README.md for did.sh
# 19.07.2018
...

```

## Contact me

If you have suggestions for improvements or if you find a bug (which is not unlikely), please contact me at ma.schroeder@outlook.com.

Otherwise feel free to use, copy and redistribute this script as you see fit.