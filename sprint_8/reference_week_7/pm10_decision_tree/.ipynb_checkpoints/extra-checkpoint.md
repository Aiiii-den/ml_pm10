Datenquellen exploriert und vorverarbeitet
Datensetze kombinieren

Modell trainiert und deploy
Was, wenn neue Daten kommen?
-> Datenvorverarbeitung automatisiert (Pipeline) - sckitlearn.pipeline
-> neue Kategorie "selten" für Werte, die kaum vorkommen - Problem: selten im Sinne von was? und wie geht man mit neuen "seltenden" Werten um
-> Train Test Split vorher & dann anhand der Test-Daten die seltenen Fälle rauszusuchen


---------------

Kategorische Daten
wie z.B. Wochentag - nummerieren 
-> Lineare Regression (z.B.) behandelt die Zahlen numerisch nach Größe & gleiche Abstand --> geordnet/ordinal
Lösung: andere Art der Ersetzung: alle Werte als eine Spalte mit boolean

Für nicht-lineare Modelle jedoch kein Problem!! (z.B. Decision Tree)