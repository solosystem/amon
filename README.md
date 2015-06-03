README.txt for amon
-------------------

generated: wav files
	   pidfile   -> currently:/home/amon/amon    moveto:/var/lock?
	   state     -> /var/run
	   cron.log  -> 
	   arecord.log -> stay on sdcard
	   solo-boot.log -> copy itself to /sdcard/logs
	   dmesg -> solo-boot.sh can copy it to /sdcard/logs

	   
	   mountpoint = /mnt/sdcard/
	   amondata / wavs / 2015-01-01
	   	      	     2015-01-02
	   		     arecord.log
			     arecord.log.backup2014-12-31.
	   
	   /home/amon/	amon.log
			state
			pidfile
			cron.log

			

-----------------------------------------------------------------------	   

todo: SAMPLERATE - if not set in amon.conf, isn't set anywhere.  Should have default value of 16k in defs.sh, prepare mic (or some other function).

todo: add target "amon test" - which records a 3 second test file.  if
given a $1 it scp's it to that machine.


First big change for some time : 

integrate cirrus logic audio card.
----------------------------------
arecord uses asoundrc file to find default audio card.
We should use this functionality.
We need to define default audio card for BOTH use cases:
the cirrus AND the snowflake.
amon should NOT know about this.  Except using a –Dhw:sndrpiwsp flag to arecord
the string sndrpiwsp is from the usermanual, but is defined in .asoundrc in /home/pi/.asoundrc

Instead, the solo-boot.sh should know what we're doing, and setup an appropriate .asoundrc for us.
except, solo is not amon, and this is really an amon thing...
Perhaps amon should do it.  But amon is never "installed", so we'd need a "firstrun" flag or something.  Perhaps just the absense of .asoundrc could cause amon to generate an appropriate asoundrc file.

to get recording working on raspi with cirrus we need to do:
/home/pi/Reset_paths.sh 
/home/pi/Record_from_DMIC.sh
arecord -c 2 -f S16_LE -r 44100 out.wav

then to test:
./Playback_to_Lineout.sh
aplay out.wav


------



TODO: use file locking in /var/run to ensure no two amons run at the same time (really unlikely)



git information
----------------
on a raspi, you do 

# git clone jdmc2@jdmc2.com:git/amon

and it copies down the repo.  Then make a change on the raspi, git
add, git commit, and now send the change up to the central repo on
jdmc2.com

BUT before doing that - ensure nothing has change on origing:

git pull (which will do a merge if it needs to)

git push  (to push your changes up to origin)
#NOTE that git push doesn't work if the currently checked-out branch on origin is master (the one you are pushing to), since that would mean changing files under that user's feet.

so to avoid this, login to origin and type git checkout blah (where
blah is any other branch than master), you can list all local branches
with "git branch" (git branch junk creates a new branch called junk)



-----
it seems that git pull on raspberry pi not only brings down the changes from origin (jdmc2.com), but also any new branches.  I think that's ok...

All this would probably be better If I used branches, but NOT for the moment - stick to one for the moment.

J.
----------
Without understanding .gitignore (which is the proper way)

Once You have made changes on a raspi, if you do git add . (to stage
the changes before a git commit), then it adds log files and other
crud, you don't want this.  so rather than git add . , go a git add -u (updates only).  This doesn't add crud and ignores logfiles.

"git add -u" looks at all the currently tracked files and stages the changes to those files if they are different or if they have been removed. It does not add any new files, it only stages changes to already tracked files.

--------------------
wavwrite(chirp([0:0.001:5]), "chirp.wav");
