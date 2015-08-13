--[[
maxoutnet.lua

written by Richard Lange

creates the MNIST maxout network from 
	"Maxout Networks" Ian J. Goodfellow, David Warde-Farley, 
	Mehdi Mirza, Aaron Courville, and Yoshua Bengio. ICML 2013
]]--

require 'torch'
require 'nn'
require 'Maxout'

net = nn.Sequential()
-- 1x28x28 input image
net:add(nn.Maxout(1, 48, 2, 8, 8, 1, 1, 0, 0, 4, 4, 2, 2))
-- 48x9x9
net:add(nn.Maxout(48, 48, 2, 8, 8, 1, 1, 3, 3, 4, 4, 2, 2))
-- 48x3x3
net:add(nn.Maxout(48, 24, 4, 8, 8, 1, 1, 3, 3, 2, 2, 2, 2))
-- 24x1x1
net:add(nn.Reshape(24))
-- 24x1
net:add(nn.Linear(24,10))
-- 10x1 output classes (note: class 1 is 0, class 10 is 9.. careful off off by one)
net:add(nn.LogSoftMax())

return net:float()