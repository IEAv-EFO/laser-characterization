# Laser Diode Characterization

* Before running the program go to Tools/Options/Front panel and disable the option "Use localized decimal point*".
Otherwise, LabVIEW will consider "," instead of "." depending on Windows language.

This code (in LabVIEW 2021) is used to obtain a characterization of lasers diode, or superluminescent diodes, in terms of input current and output optical power.
With this characterization informations such as direct modulation, minimum lasing current, and power linearity can be obtained. Plus, every optical spectrum is saved in case more detail about the laser linewdith or SLD shape is needed.

The communication is made via GPIB.
The current and temperature controller used is the LDC 3722B,
the optical spectrometer used is the Advantest Q8347.

To check the complete description refer to the <a href="Laser_diode_characterization_paper.pdf">Project Paper.</a>


Obs: The problematic device in this system is the optical spectrometer, because I couldn't made the embbeded function of wait the measurement to finish before request the data via GPIB to work. So, I implemented a simple function by monitoring the spectrometer status byte. If any errors occurs, this is most likely the cause.
