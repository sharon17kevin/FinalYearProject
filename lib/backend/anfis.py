import tensorflow as tf
import numpy as np


class ANFIS:
    def __init__(self, num_inputs, num_rules, learning_rate=1e-2):
        self.num_inputs = num_inputs
        self.num_rules = num_rules
        self.learning_rate = learning_rate

        # Initialize the model parameters
        self.mf_params = tf.Variable(tf.random.normal(shape=[self.num_inputs, self.num_rules]))
        self.rule_params = tf.Variable(tf.random.normal(shape=[self.num_rules, 1]))

        # Create the input and output placeholders
        self.inputs = tf.placeholder(shape=[None, self.num_inputs], dtype=tf.float32)
        self.targets = tf.placeholder(shape=[None, 1], dtype=tf.float32)

        # Create the fuzzy logic layer
        fuzzy_inputs = tf.map_fn(lambda x: self.fuzzy_layer(x), self.inputs)
        rule_outputs = tf.map_fn(lambda x: self.rule_layer(x), fuzzy_inputs)
        self.output = tf.reduce_sum(rule_outputs, axis=1)

        # Create the loss and optimizer
        self.loss = tf.reduce_mean(tf.square(self.targets - self.output))
        self.optimizer = tf.train.AdamOptimizer(self.learning_rate).minimize(self.loss)

        # Initialize the TensorFlow session
        self.sess = tf.Session()
        self.sess.run(tf.global_variables_initializer())

    def fuzzy_layer(self, inputs):
        inputs = tf.expand_dims(inputs, axis=1)
        inputs = tf.tile(inputs, [1, self.num_rules, 1])
        mf_params = tf.tile(tf.expand_dims(self.mf_params, axis=0), [tf.shape(inputs)[0], 1, 1])
        return tf.exp(-tf.reduce_sum(tf.square(inputs - mf_params), axis=2))

    def rule_layer(self, inputs):
        rule_outputs = tf.reduce_prod(inputs, axis=1)
        rule_outputs = tf.expand_dims(rule_outputs, axis=1)
        return tf.matmul(rule_outputs, self.rule_params)

    def train(self, inputs, targets, num_epochs):
        for epoch in range(num_epochs):
            loss, _ = self.sess.run([self.loss, self.optimizer], feed_dict={self.inputs: inputs, self.targets: targets})
            print('Epoch {0}: Loss = {1}'.format(epoch, loss))

    def predict(self, inputs):
        return self.sess.run(self.output, feed_dict={self.inputs: inputs})
