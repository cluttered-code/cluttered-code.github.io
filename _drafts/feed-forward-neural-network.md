---
layout: post
title: "Feed Forward Neural Network"
date: 2014-07-05 16:00:00
categories: [neural network]
tags: [java8, stream]
---

Lets finish building our `Neural Network` using `Java8 Streams`.

Previous post: [Coding Neurons]({{"/neural network/2014/06/26/coding-neurons/" | prepend: site.baseurl}})

**Github Source Code:** <a href="https://github.com/cluttered-code/neural-network" target="_blank">neural-network</a>

---

### Overview

In a feed forward neural network all data flows through the network in one direction across all layers. 
The **first** layer is a special layer known as the `input layer`, followed by **any number** of `hidden layers`, 
and the **last** layer is the `output layer`. All the outputs from each `Neuron` in each layer is passed to the next layer. 
It is up to the individual `Neuron` to determine the weight each output from the previous layer will have for its own activation.

![Feed Forward Network](/images/feed-forward-network.png)

---

### Layers

**Input Layer**

The input layer is typically comprised of a `Neuron` for each value being input in to the network. They accept a **single input** 
and use the linear activation function acting as a pass-through, effectively piping the input value directly into the next layer 
in the neural network. It isn't required that the `Neuron` use the linear activation function but it is very common.

**Output Layer**

The output layer is very similar to the input layer in the regard that it contains a `Neruon` for each value being output, 
however it is less common to see the linear activation function being used here. It is still common to use the linear activation 
function but just as common to see the sigmoid activation function being used to normalize values for boolean outputs, as an example.

**Hidden Layers**

The hidden layers are the layers that actually give the neural network its "intelligence". Most problems can be solved with a single hidden 
layer. The More layers that are added the longer it takes to sufficiently train the neural network. The `Neurons` in the hidden layers 
should rarely use the linear activation function.

#### **Code**

Each `FeedForwardLayer` will need a list of `Neurons` and a method that accepts the outputs from a previous layer passes them to each neuron 
fires the neurons and then returns the array of ouputs from the neurons. I used one of the new **Java8 Streams** to accomplish this.

{% highlight java %}
public class FeedForwardLayer {

    protected List<Neuron> neurons;

    public FeedForwardLayer(final List<Neuron> neurons) {
        this.neurons = neurons;
    }

    public double[] fire(final double[] inputs) {
        return neurons.stream()
                .mapToDouble(neuron -> neuron.fire(inputs))
                .toArray();
    }
}
{% endhighlight %}

**Source Code:** <a href="https://github.com/cluttered-code/neural-network/blob/master/src/main/java/com/clutteredcode/ann/FeedForwardLayer.java" target="_blank">FeedForwardLayer</a>

The input layer doesn't pass all the inputs to each neuron it only passes one input to each neuron so we need a class that overrides the 
`FeedForwardLayer` fire method. I creatd a `FeedForwardInputLayer`. We can't use the java stream here because the index of the inputs is 
changing.

{% highlight java %}
public class FeedForwardInputLayer extends FeedForwardLayer {

    public FeedForwardInputLayer(final List<Neuron> neurons) {
        super(neurons);
    }

    @Override
    public double[] fire(final double[] inputs) {
        final double[] outputs = new double[neurons.size()];

        for(int i = 0; i < inputs.length; ++i)
            outputs[i] = neurons.get(i).fire(inputs[i]);

        return outputs;
    }
}
{% endhighlight %}

**Source Code:** <a href="https://github.com/cluttered-code/neural-network/blob/master/src/main/java/com/clutteredcode/ann/FeedForwardInputLayer.java" target="_blank">FeedForwardInputLayer</a>

---

### Network

The last piece to having a funcional `Neural Network` is the `FeedForwardNetwork` itself. All it has to do is accept an array of inputs, 
pass the inputs to the first layer, pass the outputs of the previous layer to the next layer and return the outputs of the process.

This is accomplished through another simple class similar to the`FeedForwardLayer` class.

{% highlight java %}
public class FeedForwardNetwork {

    protected List<FeedForwardLayer> layers;

    public FeedForwardNetwork(final List<FeedForwardLayer> layers) {
        this.layers = layers;
    }

    public double[] fire(final double[] inputs) {
        double[] currentInputs = inputs;

        for (final FeedForwardLayer layer : layers)
            currentInputs = layer.fire(currentInputs);

        return currentInputs;
    }
}
{% endhighlight %}

**Source Code:** <a href="https://github.com/cluttered-code/neural-network/blob/master/src/main/java/com/clutteredcode/ann/FeedForwardNetwork.java" target="_blank">FeedForwardNetwork</a>

