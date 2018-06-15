# REXCO
REXCO Project :Physical exercise increases overall brain oscillatory activity but does not influence inhibitory control in young adults
Ciria, Luis F.; Perakakis, Pandelis; Luque-Casado, Antonio; Sanabria, Daniel

Methods and design

Participants

We recruited 20 young males (19-32 years old, average age 23.8 years old) from the University of Granada (Spain). 
All participants met the inclusion criteria of normal or corrected to normal vision, reported no neurological, cardiovascular 
or musculoskeletal disorders, were taking no medication and reporting less than 3 hours of moderate exercise per week. 
Participants were required to maintain regular sleep-wake cycle for at least one day before each experimental session and to abstain 
from stimulating beverages or any intense exercise 24 hours before each session. From the 20 participants, one was excluded from the 
analyses because he did not attend to the last experimental session and another one because of technical issues. 
Thus, only data from the remaining 18 participants are reported. All subjects gave written informed consent before the study and 
received 20 euros for their participation. The protocol was approved in accordance with both the ethical guidelines of the 
University of Granada and the Declaration of Helsinki of 1964.

Apparatus and materials

All participants were fitted with a Polar RS800 CX monitor (Polar Electro Öy, Kempele, Finland) to record their heart rate (HR) 
during the incremental exercise test. We used a ViaSprint 150 P cycle ergometer (Ergoline GmbH, Germany) to induce physical effort 
and to obtain power values, and a JAEGER Master Screen gas analyser (CareFusion GmbH, Germany) to provide a measure of gas exchange 
during the effort test. Flanker task stimuli were presented on a 21-inch BENQ screen maintaining a fixed distance of 50 cm between 
the head of participants and the center of the screen. E-Prime software (Psychology Software Tools, Pittsburgh, PA, USA) was used for
stimulus presentation and behavioural data collection.

Procedure

Participants completed two counterbalanced experimental sessions of approximately 120 min each. Sessions were scheduled on different 
days allowing a time interval of 48–72 hours between them to avoid possible fatigue and/or training effects. On each experimental 
session (see Fig. 1), participants completed a 15’ resting state period sitting in a comfortable chair with closed eyes. 
Subsequently, they performed 10’ warm-up on a cycle-ergometer at a power load of 20% of their individual VO2 VAT, following by 30’ 
exercise at 80% (moderate-intensity exercise session) or at 20% (light intensity exercise session) of their VO2 VAT (see Table 1). 
Upon completion of the exercise, a 10’ cool down period at 20% VO2 VAT of intensity followed. Each participant set his preferred 
cadence (between 60-90 rpm • min-1) before the warm-up and was asked to maintain this cadence throughout the session in order to match
conditions in terms of dual-task demands. Later, participants waited sitting in a comfortable chair until their heart rate returned to 
within their 130% of heart rate at resting (average waiting time 5’ 44’’). The first flanker task was then performed for 6’, followed 
by a 15’ resting period with closed eyes. Finally, they again completed the 6’ flanker task.

Flanker task

We used a modified version of the Eriksen flanker task based on that reported in Eriksen and Eriksen (1974). The task consisted of a 
random presentation of a set arrows flanked by other arrows that faced the same or the opposite direction. In the congruent trials, 
the central arrow is flanked by arrows in the same direction (e.g., <<<<< or >>>>>), while in the incongruent trials, the central arrow 
is flanked by arrows in the opposite direction (e.g., <<><< or >><>>). Stimuli were displayed sequentially on the center of the screen 
on a black background. Each trial started with the presentation of a white fixation cross in a black background with random duration 
between 1000 and 1500 ms. Then, the stimulus was presented during 150 ms and a variable interstimulus interval (1000–1500 ms). 
Participants were instructed to respond by pressing the left tab button with their left index finger when the central arrow 
(regardless of condition) faced to the left and the right tab button with their right index finger when the central arrow faced to the 
right. Participants were encouraged to respond as quick as possible, being accurate. A total of 120 trials were randomly presented 
(60 congruent and 60 incongruent trials) in each task. Each task lasted for 6 minutes approximately without breaks.

EEG recording and analysis

EEG data were recorded at 1000 Hz using a 30-channel actiCHamp System (Brain Products GmbH, Munich, Germany) with active electrodes 
positioned according to the 10-20 EEG International System and referenced to the Cz electrode. The cap was adapted to individual 
head size, and each electrode was filled with Signa Electro-Gel (Parker Laboratories, Fairfield, NJ). Participants were instructed to 
avoid body movements as much as possible, and to keep their gaze on the center of the screen during the exercise. Electrode impedances 
were kept below 10 kΩ. EEG preprocessing was conducted using custom Matlab scripts and the EEGLAB (Delorme & Makeig, 2004) and Fieldtrip 
(Oostenveld et al., 2011) Matlab toolboxes. EEG data were resampled at 500 Hz, bandpass filtered offline from 1 and 40 Hz to remove 
signal drifts and line noise, and re-referenced to a common average reference. Horizontal electrooculograms (EOG) were recorded by 
bipolar external electrodes for the offline detection of ocular artifacts. The potential influence of electromyographic (EMG) activity 
in the EEG signal was minimized by using the available EEGLAB routines (Delorme & Makeig, 2004). Independent component analysis was used 
to detect and remove EEG components reflecting eye blinks (Hoffmann and Falkenstein, 2008). Abnormal spectra epochs which spectral 
power deviated from the mean by +/-50 dB in the 0-2 Hz frequency window (useful for catching eye movements) and by +25 or -100 dB 
in the 20-40 Hz frequency window (useful for detecting muscle activity) were rejected. On average, 5.1% of epochs per participant 
were rejected.

Spectral power analysis. Processed EEG data from each experimental period (Resting 1, Warm-up, Exercise, Cool Down, Flanker Task 1, 
Resting 2, Flanker Task 2) were subsequently segmented to 1-s epochs. The spectral decomposition of each epoch was computed using 
Fast Fourier Transformation (FFT) applying a symmetric Hamming window and the obtained power values were averaged across experimental 
periods.

Event-Related Spectral Perturbation (ERSP) analysis. Task-evoked spectral EEG activity was assessed by computing ERSP in epochs extending
from –500 ms to 500 ms time-locked to stimulus onset for frequencies between 4 and 40 Hz. Spectral decomposition was performed using
sinusoidal wavelets with 3 cycles at the lowest frequency and increasing by a factor of 0.8 with increasing frequency. Power values 
were normalized with respect to a −300 ms to 0 ms pre-stimulus baseline and transformed into the decibel scale.
