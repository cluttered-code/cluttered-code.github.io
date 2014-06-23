---
layout: post
title: "Coding Neurons"
categories: [neural network]
tags: [neuron, java8, lambda]
---

In this post we'll begin building the first piece of a `Neural Network`, a `Neuron`, 
from scratch using `Java8` and `lambda` functions.

The previous post contained a brief history of the artificial neuron as well as a naive comparison to a biological neuron.
`Link to '2014-06-22-brain-new-beginnings'`

**There are some complex equations in this post, I'll try to make it as easy to follow as possible. 
Feel free to post questions in the comments section.**

---

### Overview

Lets look at that beautiful picture I made of an artificial neuron again!

![Artificial Neuron](/images/artificial-neuron.png)

The neuron is **given a list of inputs and returns a single output**. 
I will be using `double` values for all of my inputs and outputs. 
You can use use other types, but I have found that anything I need 
the neural network to compute can be represented by a `double`.

A dot product calculation is performed on the **inputs** and **weights** and added to the **bias**.

$$ bias + \sum_{i=1}^{n} input_{i} (weight_{i}) $$

That is then passed into one of the following **activation functions** and returned as the **output**

  * **Linear:** $$ f(x) = x $$
  * **Sigmoid:** $$ f(x) = \frac{1}{1 + e^{-x}} $$
  * **Hyperbolic Tangent:** $$ f(x) = \frac{1 - e^{-2x}}{1 + e^{-2x}} $$
  
---

### Activation Function

The activation function is used to normalize the value calculated by the summation phase of the neuron.

![Graphs](/images/activation-function-graphs.png)
Original image obtained from: [www.intechopen.com](http://www.intechopen.com/source/html/15938/media/image22.png) 

**Linear**

This functions performs no normalization and acts as a pass through returning the output of the neuron's summation. 
This cannot be chosen used in neurons that will learn using back propagation because the derivative is 0, 
This function is typically only used in the input and output layers of the neural network. 
**More on that later**.

**Sigmoid**

The sigmoid function will normalize a given input into a value between 0 and 1. 
This is perfect for outputting a binary response, true/false or on/off. 
This is also the preferred function for dealing with data sets containing only non-negative states.

**Hyperbolic Tangent**

The hyperbolic tangent function will normalize a given input into a value between -1 and 1. 
This is more versatile than the sigmoid function and can be used to allow neurons to cancel each other out. 
Can be used to more effectively determine buy/hold/sell states in data with negative and positive states.

**Code**

Each neuron will need an `ActivationFunction`. 
The function can be different for individual neurons and is a single function so it is the 
perfect place to use the new **Java8 lambdas**.

In java8 lambda functions are inline interfaces with a single method. 
before we use lambda we'll have to create the `ActivationFunction` interface.

{% highlight java %}
public interface ActivationFunction {

    public double activate(final double input);
}
{% endhighlight %}

Now we can define these functions as lambdas!

There is a finite number of possible functions, I hope I made that obvious enough. 
When there is a finite number of options it's enumerator time. 
I'm lazy so I only want to have to pass an `enum` to my neuron and let it take care of the rest. 
This will alleviate the need to check for nulls or write the lambda functions all over the place, 
causing a maintenance nightmare. I like enumerators, you aren't already you should introduce yourself 
to them and become friends.

{% highlight java %}
public enum ActivationType {
    LINEAR,
    SIGMOID,
    TAN_H;
}
{% endhighlight %}

Now we need a way to map from the `ActivationType` to the actual function. Enumerators in java are 
objects just like almost everything else, we just have to add a method to do use the `enum` to give us what we want. 

**SPOILER ALERT, ACTUAL LAMBDA AHEAD** I added this method to `ActivationType` to accomplish that.
{% highlight java %}
public ActivationFunction getFunction() {
    if (this == TAN_H)
        return (final double input) -> Math.tanh(input);

    if (this == SIGMOID)
        return (final double input) -> 1 / (1 + Math.exp(-input));

    // Default: LINEAR
    return (final double input) -> input;
}
{% endhighlight %}

All you have to do to get your `ActivationFunction` now is:
{% highlight java %}
ActivationType.TAN_H.getFunction();
{% endhighlight %}

*Side Note:* we didn't have to use lambdas here. We could have written a class for each function and had it 
implement `ActivationFunction` but then we would have 3 more classes. This way all the definitions 
are all in one convenient place `ActivationType`.