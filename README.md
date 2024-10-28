# noise-reduction-butterworth
Designing a butterworth filter to supress noise from an audio file in MATLAB with a maximally flat response in the passband or stopband.

# Problem:
Improving the quality of human speech by removing unwanted noise is a complex engineering challenge. Environmental noise and poor recording quality can degrade the effectiveness of speech as a means of communication. In order to address this issue, noise reduction techniques must be employed to enhance the clarity of speech signals. However, it is crucial to design filters with great care to achieve effective noise reduction while avoiding any undesired distortions or artifacts that could compromise the quality of the speech signal.

# Infinite Impulse Response (IIR) filters:
**Butterworth filter:** A lowpass or high pass filter that has a maximally flat response in the passband or stopband. Example: Used in audio processing for equalization or to remove unwanted frequencies from recordings.

![image](https://github.com/user-attachments/assets/2d5a52e8-74ce-46e8-8bc9-3e5b6da42e9e)

**Chebyshev filter:** A filter that has a steeper roll-off than the Butterworth filter, but with ripples in the passband or stopband. Example: Used in radio communications to attenuate unwanted frequencies.

![image](https://github.com/user-attachments/assets/5fae25ec-40c6-486b-b729-c1152961792c)

# Why we use IIR Filters?
We use Infinite Impulse Response (IIR) filters for several reasons, including:

1. **Greater flexibility in filter design:** IIR filters offer greater flexibility in filter design compared to FIR filters, allowing for more precise shaping of the filter response.
2. **Smaller filter size:** IIR filters typically require fewer coefficients than FIR filters to achieve the same level of filtering, resulting in a smaller filter size and lower computational requirements.
3. **Efficient processing of certain types of signals:** IIR filters are well-suited to processing certain types of signals with specific frequency characteristics, such as audio and speech signals, due to their ability to achieve sharp roll-off and selective frequency attenuation.
4. **Ability to handle feedback:** IIR filters can handle feedback in the filter structure, allowing for the creation of complex filters with resonant and notch characteristics.
5. **Real-time processing:** Due to their smaller size and lower computational requirements, IIR filters are often used in real-time processing applications, such as audio and video processing, where low latency is critical.

However, there are also some potential drawbacks to using IIR filters, such as stability issues and phase distortion, which must be carefully considered when designing and implementing IIR filters in practical applications.

# Why use Chebyshev Filter?
We utilize Chebyshev filters for several reasons, such as:

1. **Sharper transition:** Chebyshev filters have a sharper transition than other filters like Butterworth filters, providing more accurate filtration of specific frequency ranges.
2. **Design versatility:** Chebyshev filters offer design flexibility, enabling the balance between passband ripple and roll-off steepness to be tailored to meet the needs of a particular application.
3. **Efficient use of filter coefficients:** Chebyshev filters can achieve a given level of filtering with fewer coefficients than other filter types, resulting in lower computational requirements and smaller filter size.
4. **Effective for narrow-band filtering:** Chebyshev filters are particularly effective for narrow-band filtering applications, such as in wireless communications, due to their ability to achieve high levels of attenuation within a specific frequency band.
5. **Effective in the presence of noise:** Chebyshev filters are effective in the presence of noise, as they can provide sharp filtering with minimal distortion of the desired signal.

However, one potential drawback to using Chebyshev filters is that they can introduce passband ripple, which may be undesirable in some applications. Additionally, the tradeoff between roll-off steepness and passband ripple must be carefully considered when designing and implementing Chebyshev filters to ensure that the filter meets the specific requirements of the application.

One disadvantage of using Chebyshev filters is that they may create passband ripple, which can be unwanted in some situations. It is important to carefully evaluate the tradeoff between the steepness of the roll-off and the amount of passband ripple when designing and utilizing Chebyshev filters to ensure that they are tailored to meet the specific needs of the application.

# Designing

$$F_s=16kHz$$

$$f_{pass}=4000Hz$$

$$f_{stop}=4010 Hz$$

$$w_{pass} = \frac{2πf_{pass}}{f_s} = \frac{2π(4000)}{16000} = 1.570796$$

$$w_{stop} = \frac{2πf_{stop}}{f_s} = \frac{2π(4010)}{16000} = 1.57472$$

$$∩_{pass} = tan(\frac{ω_{pass}}{2}) = tan⁡(1.5707962)= 0.999$$

$$n_{stop} = tan(\frac{ω_{stop}}{2}) = tan⁡(1.0042)= 1.004$$

$$∴A_{pass} = 1$$

$$∴A_{stop} = 150$$

$$e_{pass} = \sqrt{10^{\frac{A_{pass}}{10}}}-1= 10110-1=0.5088$$

$$e_{stop} =\sqrt{10^{\frac{A_{stop}}{10}}}-1= 101010-1=3$$

$$N_{exact} = \frac{ln(\frac{e_{stop}}{e_{pass}})}{ln⁡(\frac{n_{stop}}{n_{pass}})} = \frac{ln(30.5088)}{ln⁡(\frac{1.004}{0.999})}=355.3$$

$$N=356$$

$$∩°=\frac{n_{pass}}{(10^{\frac{A_{pass}}{10}}-1)^{1/2N}}= \frac{0.999}{(10^{\frac{1}{10}}-1)^{1/2(356)}}=2.847$$

$$theta_1=\frac{pi}{2(356)}(356-1+2(1))=1.5752$$

$$theta_2= .$$

$$theta_3= .$$

$$s_1=n°e^{jtheta_1}=2.847$$

$$s_1= -0.004+0.99j$$

$$s_2= .$$

$$s_3= .$$

# Unfiltered Vs Filtered Response:

![image](https://github.com/user-attachments/assets/ca2d5443-95f0-4bcb-a6f2-b71ac44c22f0)

# Chebyshev Filter Magnitude and Phase Plots

![image](https://github.com/user-attachments/assets/72b5c05d-2afa-4653-b717-02d52d5cecea)

