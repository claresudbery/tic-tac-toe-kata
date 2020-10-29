<!--ts-->

# Table of Contents

 * [Performance](#performance)
 * [Visualising Grids](#visualising-grids)
   * [Diagram A](#diagram-a)
   * [Diagram B](#diagram-b)
   * [Diagram C](#diagram-c)
   * [Diagram D](#diagram-d)
   * [Diagram E](#diagram-e)
   * [Diagram F](#diagram-f)
   * [Diagram G](#diagram-g)
   * [Diagram H](#diagram-h)
   * [Diagram I](#diagram-i)
   * [Diagram J](#diagram-j)
   * [Diagram K](#diagram-k)
   * [Diagram L](#diagram-l)
   * [Diagram M](#diagram-m)
   * [Diagram N](#diagram-n)
<!--te-->

# Performance

- The test for scoring an empty grid consistently took around 1.2 seconds with the `while` loop in `Intelligence.get_minimax_score`. 
    - With the `each` loop used instead, it took 6.7 seconds. 
        - Also, the whole test suite took 17 seconds instead of 3 seconds.
    - With the new `find_instant_winning_move` method in place, it took about 1.15 seconds.
        - The whole test suite was also slightly quicker - at 2.57 seconds instead of 2.9 (and with 3 extra tests).
- The test for choosing the first winning move for the grid in diagram F consistently took around 0.016 seconds with the `each` loop at the top level in `Intelligence.choose_move_using_unbeatable_ai`.
    - Replacing the `each` loop with a `while` loop reduced the time to an average of 0.011.

# Visualising Grids

I drew a lot of diagrams while I was coding this, to get my head around all the different possible scenarios and test cases, and to visualise how the minimax algorithm would help the AI to win the game, and how I could optimise to reduce unnecessary recusrive depth (see [section on performance](#performance)).

Nearly all of these diagrams are referenced by test cases in [intelligence_spec.rb](https://github.com/claresudbery/tic-tac-toe-kata/blob/master/spec/intelligence_spec.rb).

## Diagram A

(aka diagram M.)

This one came from me taking the example in [this Medium article](https://towardsdatascience.com/tic-tac-toe-creating-unbeatable-ai-with-minimax-algorithm-8af9e52c1e7d) and imagining what if the opponent had played a slightly different move at the start (my initial rough notes are in [Diagram N](#diagram-n)).

This is an example of having a choice between winning or drawing.

![Diagram A](/images/DiagramA.png)

## Diagram B

(aka diagram D.)

This is an example of having a choice between drawing or losing. [Diagram H](#diagram-h) is also an example of the same scenario.

![Diagram B](/images/DiagramB.png)

## Diagram C

This is an example of where loss is unavoidable.

![Diagram C](/images/DiagramC.png)

## Diagram D

This is the same as [Diagram B](#diagram-b).

## Diagram E

This is an example of where there is more than way of winning, but you do have a choice between an instant win and a slow win ([Diagram I](#diagram-i) and [Diagram J](#diagram-j) are also examples of this).

![Diagram E](/images/DiagramE.png)

## Diagram F

This is an example of where some moves will lead to a definite win but some could lead to a draw.

![Diagram F](/images/DiagramF.png)

## Diagram G

This is an example of where there are multiple non-instant winning moves.

![Diagram G](/images/DiagramG.png)

## Diagram H

This is an example of having a choice between drawing or losing. [Diagram B](#diagram-b) is also an example of the same scenario.

![Diagram H](/images/DiagramH.png)

## Diagram I

This is an example of where there is more than way of winning, but you do have a choice between an instant win and a slow win ([Diagram E](#diagram-e) and [Diagram J](#diagram-j) are also examples of this).

![Diagram I](/images/DiagramI.png)

## Diagram J

This is an example of where there is more than way of winning, but you do have a choice between an instant win and a slow win ([Diagram E](#diagram-e) and [Diagram I](#diagram-i) are also examples of this).

![Diagram J](/images/DiagramJ.png)

## Diagram K

This is an example of where you are going to lose no matter what, but still it would look odd if the AI didn't choose to block the instant win. I added a test case for this in [intelligence_spec.rb](https://github.com/claresudbery/tic-tac-toe-kata/blob/master/spec/intelligence_spec.rb), then removed it in [commit 230bc17](https://github.com/claresudbery/tic-tac-toe-kata/commit/230bc17) because this scenario would only ever occur if you started out playing "stoopid pooter" and then switched to "clever AI" mid game. Still, given that users can switch between clever and stupid AI, I decided to implement it after all. See [commit c1efead](https://github.com/claresudbery/tic-tac-toe-kata/commit/c1efead).

![Diagram K](/images/DiagramK.png)

## Diagram L

This is an example of the notation I used when I was mapping out long chains of moves. This is because I ran out of space if I used the approach used in the other diagrams on this page!

![Diagram L](/images/DiagramL.png)

## Diagram M

This is the same as [Diagram A](#diagram-a).

## Diagram N

This one came from me taking the example in [this Medium article](https://towardsdatascience.com/tic-tac-toe-creating-unbeatable-ai-with-minimax-algorithm-8af9e52c1e7d) and imagining what if the opponent had played a slightly different move at the start. These are my initial rough notes, and then I took two of the possibilities and drew them out properly in [Diagram A](#diagram-a) and [Diagram C](#diagram-c).

![Diagram N](/images/DiagramN.png)
