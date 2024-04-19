WITH codes(color,digit) AS (
  VALUES
  ('black'  , 0),
  ('brown'  , 1),
  ('red'    , 2),
  ('orange' , 3),
  ('yellow' , 4),
  ('green'  , 5),
  ('blue'   , 6),
  ('violet' , 7),
  ('grey'   , 8),
  ('white'  , 9)
)
 UPDATE color_code
    SET result = c1.digit || c2.digit
   FROM codes c1, codes c2
  WHERE color_code.color1=c1.color
    AND color_code.color2=c2.color;
