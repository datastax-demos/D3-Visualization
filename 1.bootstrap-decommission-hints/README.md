# Bootstrap, Decommission, Hints

The following d3.js animation should be self-contained with a UI for initiating
3 actions. Each node and piece of data should be represented as
circles of different sizes and colors depending on type and state, respectively.

## UI

There should be 2 controller circles that start out in the bottom left corner
in a horizontal row, but can be dragged together and placed elsewhere on the screen.

The Kill process will occur when a Stable node is clicked. The Restart process
will occur when a Dead node is clicked.

## Color Palette

These colors should be the considered the primary color scheme. Feel free
to choose the additional required colors along the same palette.

    #027995
    #CC6600
    #DDAF53
    #007896
    #C85E12

The colors and definitions per action are as follows:

* Bootstrapping:
    * Blue
    * The node receives data as it joins into an existing ring
* Stable:
    * Green
    * Sending and receiving data
* Dead:
    * Red
    * The node is offline
* Restarting:
    * Yellow
    * Building memory tables
* Decommissioned:
    * Burnt Orange
    * The node is sending data as it leaves the ring

The colors, frequency, direction, and definitions for data types are as follows
on smaller, different sized circles:

* Data
    * Purple
    * Constant
    * (Stable, Decommission) to (Bootstrapping, Stable)
    * A constant flow of database mutations
* Hints
    * Teal
    * 3 in flight, per node, at all times
    * Stable to (Bootstrapping, Stable)
    * Updates sent between nodes to ensure consistency
* Gossip
    * Pink
    * 1 every 2 seconds, per node
    * (Bootstrapping, Stable, Restarting, Decommissioned) to
    (Bootstrapping, Stable, Dead, Restarting, Decommissioned)
    * Heartbeat pings to check on node health and availability

Visual aids should be included in the center of the circle for color blindness.

The background should be black, but easily changeable in the future by
non-technical users at the top of the source code.

# Actions

## 0. Normal Operation

Under normal operations, stable nodes are larger green circles and receive
data represented by smaller data circles.

For simplicity, image-1.0 and image-1.1 represent the same state where arrows
replace data in the sketch.

The nodes should always strive for equidistant lengths between all other nodes.
[image-1.0] [image-1.1] [image-1.3] [image-1.5] [image-1.6]

## 1. Bootstrap

The Bootstrap controller causes new nodes to enter the animation as smaller
blue nodes that receive new data. [image-1.2] [image-1.4]

Once the node reaches equilibrium and equal size with other nodes, it should
turn green and begin to also send data to the other nodes.
[image-1.3] [image-1.5]

This act should be able to perform infinitely. [image-1.6]

## 2. Decommission

When the Decommission controller is activated a random node turns Burnt Orange
and begins shrinking and traveling away from the cluster. [image-2.1]

What should be left are the remaining nodes that filled in the missing gap. [image-2.2]

All nodes except the last 1 can be decommissioned.

## 3. Hint Delivery

Upon clicking on a Stable node, it will be Killed and turn red. Only Gossip
pings may contact the node. [image-3.1]

When a Dead node is clicked again, it should change from red to yellow, wait 5 seconds,
then turn green. Once Stable, hints should flow from all nodes at a heavier throughput
to the restarted node for 10 seconds. Data should always be flowing to Stable nodes.
[image-3.2]

After 10 seconds, the cluster settles down. [image-3.3]
