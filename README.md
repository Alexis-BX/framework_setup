# Framework laptop setup for Ubuntu 21
This is a script for setting up the [Framework laptop](frame.work) for Ubuntu 21.04.

It does the following, in order:
- fixing the microphone input on the headphone jack
- adds a deep sleep state for when the lid is closed
- enables fingerprint login
- enables fingerprint authentification for root in the terminal

When the PAM configuration window opens select the 'Fingerprint authentication' with space.

This list of commands was compiled by experimentation and is based on the many comments on the Framework community page, thank you all for your help!

Please feel free to commit improvements or branches for different distributions.

#### Added note on wifi
In the tested version the wifi card worked out of the box. 

If this is not your case go to [Linux Support for Intel Wireless Adapters](https://www.intel.com/content/www/us/en/support/articles/000005511/wireless.html)
and download [iwlwifi-ty-59.601f3a66.0.tgz](https://wireless.wiki.kernel.org/_media/en/users/drivers/iwlwifi-ty-59.601f3a66.0.tgz) for Intel® Wi-Fi 6 AX210.

Copy the file to your Framework.

Open a terminal window in the folder containing the zip and run the following:

```
tar xf iwlwifi-ty-59.601f3a66.0.tgz`
sudo cp -b iwlwifi-ty-59.601f3a66.0/iwlwifi-ty-a0-gf-a0-59.ucode /lib/firmware/
reboot
```
