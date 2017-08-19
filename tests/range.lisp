(in-package :serapeum.tests)

(def-suite range :in serapeum)
(in-suite range)

(defmacro test-range (expr result)
  `(progn
     (locally (declare (inline range))
       (is (vector= ,expr ,result :test #'=)))
     (locally (declare (notinline range))
       (is (vector= ,expr ,result :test #'=)))))

(test empty-range
  (test-range (range 0 0) #())
  (test-range (range 0) #())
  (test-range (range 1 0) #()))

(test bit-range
  (test-range (range 0 1) #(0)))

(test integer-range
  (test-range (range 10)
              #(0 1 2 3 4 5 6 7 8 9))

  (test-range (range 1 11)
              #(1 2 3 4 5 6 7 8 9 10))

  (test-range (range 0 30 5)
              #(0 5 10 15 20 25))

  (test-range (range 0 10 3)
              #(0 3 6 9))

  (test-range (range 0 4 2)
              #(0 2))

  (test-range (range 0 5 2)
              #(0 2 4))

  (test-range (range 0 6 2)
              #(0 2 4))

  (test-range (range 0 6 2)
              #(0 2 4))

  (test-range (range 0 7 2)
              #(0 2 4 6)))

(test negative-integer-range
  (test-range (range -5 5)
              #(-5 -4 -3 -2 -1 0 1 2 3 4))

  (test-range (range -100 100 10)
              #(-100 -90 -80 -70 -60 -50 -40 -30 -20 -10
                0 10 20 30 40 50 60 70 80 90))

  (test-range (range 100 0 -10)
              #(100 90 80 70 60 50 40 30 20 10))

  (test-range (range 10 -10 -1)
              #(10 9 8 7 6 5 4 3 2 1 0 -1 -2 -3 -4 -5 -6 -7 -8 -9))

  (test-range (range 0 -10 -1)
              #(0 -1 -2 -3 -4 -5 -6 -7 -8 -9)))

(test float-range
  (test-range (range 0 8/10 1/10)
              #(0 1/10 1/5 3/10 2/5 1/2 3/5 7/10))

  (test-range (range 0 0.8d0 0.1d0)
              #(0 0.1d0 0.2d0 0.30000000000000004d0 0.4d0 0.5d0 0.6d0 0.7d0))

  (is (= (length (range 0.4d0 0.6d0 0.2d0)) 1))

  (is (= (length (range 0.4s0 0.8s0 0.2s0)) 2)))
