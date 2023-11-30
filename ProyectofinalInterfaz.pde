// codigo para processing

import java.util.Random;
import javax.swing.JOptionPane;

int n;
int[][] laberinto;
int inicioX, inicioY, finX, finY; 
int caminosTrampa;

void setup() {
  size(1400, 800);

  while (true) {
    try {
      String inputN = JOptionPane.showInputDialog("Digite el número de filas y columnas del laberinto (debe ser mayor o igual a 2):");
      n = Integer.parseInt(inputN);
      if (validarTamaño(n)) {
        break;
      } else {
        JOptionPane.showMessageDialog(null, "El tamaño debe ser mayor o igual a 2. Inténtelo nuevamente.");
      }
    } catch (Exception e) {
      JOptionPane.showMessageDialog(null, "Ingrese un número válido. Inténtelo nuevamente.");
    }
  }

  while (true) {
    try {
      String inputInicioX = JOptionPane.showInputDialog("Digite la coordenada de inicio en X:");
      inicioX = Integer.parseInt(inputInicioX);
      String inputInicioY = JOptionPane.showInputDialog("Digite la coordenada de inicio en Y:");
      inicioY = Integer.parseInt(inputInicioY);
      if (validarCoordenadas(inicioX, n) || validarCoordenadas(inicioY, n)) {
        break;
      } else {
        JOptionPane.showMessageDialog(null, "Las coordenadas deben estar en las fronteras del laberinto. Inténtelo nuevamente.");
      }
    } catch (Exception e) {
      JOptionPane.showMessageDialog(null, "Ingrese un número válido. Inténtelo nuevamente.");
    }
  }

  while (true) {
    try {
      String inputFinX = JOptionPane.showInputDialog("Digite la coordenada de fin en X:");
      finX = Integer.parseInt(inputFinX);
      String inputFinY = JOptionPane.showInputDialog("Digite la coordenada de fin en Y:");
      finY = Integer.parseInt(inputFinY);
      if (validarCoordenadas(finX, n) || validarCoordenadas(finY, n)) {
        break;
      } else {
        JOptionPane.showMessageDialog(null, "Las coordenadas deben estar en las fronteras del laberinto. Inténtelo nuevamente.");
      }
    } catch (Exception e) {
      JOptionPane.showMessageDialog(null, "Ingrese un número válido. Inténtelo nuevamente.");
    }
  }

  laberinto = new int[n][n];
  caminosTrampa = n;

  int rest = Integer.parseInt(JOptionPane.showInputDialog("Digite 1 si quiere ver el camino y 2 si quiere Jugar"));
  if (rest == 1) {
    generarCaminoAleatorio(laberinto, finX, finY, inicioX, inicioY);
  } else {
    generarCaminoAleatorio(laberinto, finX, finY, inicioX, inicioY);
    generarCaminoTrampa(laberinto, n, finX, finY, caminosTrampa, 0);
  }
}

void draw() {
  background(255);
  // Visualizar el laberinto
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (laberinto[i][j] == 1) {
        fill(255);
      } else if (laberinto[i][j] == 0) {
        fill(2, 60, 104);
      }
      rect(j * width / n, i * height / n, width / n, height / n);
    }
  }

  fill(0, 255, 0);
  rect(inicioX * width / n, inicioY * height / n, width / n, height / n);
  fill(255, 0, 0); // Fin en rojo
  rect(finX * width / n, finY * height / n, width / n, height / n);
}

void keyPressed() {
  if (keyCode == UP && inicioY > 0 && laberinto[inicioY - 1][inicioX] == 1) {
    inicioY--;
  } else if (keyCode == DOWN && inicioY < n - 1 && laberinto[inicioY + 1][inicioX] == 1) {
    inicioY++;
  } else if (keyCode == LEFT && inicioX > 0 && laberinto[inicioY][inicioX - 1] == 1) {
    inicioX--;
  } else if (keyCode == RIGHT && inicioX < n - 1 && laberinto[inicioY][inicioX + 1] == 1) {
    inicioX++;
  }

  if (inicioX == finX && inicioY == finY) {
    JOptionPane.showMessageDialog(null, "¡Felicidades! Has llegado al final del laberinto.\nGracias por jugar.");
    noLoop(); // Detener el bucle de dibujo
  }
}

public static void inicioLaberintoRecursivo(int laberinto[][], int n, int i, int j) {
  if (i < n) {
    if (j < n) {
      laberinto[i][j] = 0;
      inicioLaberintoRecursivo(laberinto, n, i, j + 1);
    } else {
      inicioLaberintoRecursivo(laberinto, n, i + 1, 0);
    }
  }
}

    static void generarCaminoAleatorio(int[][] laberinto, int finX, int finY, int x, int y) {
        Random random = new Random();

        if (x == finX && y == finY) {
            return;
        }

              if (random.nextBoolean()) {
                if (x < finX) {
                    x++;
                }else{
                    x--;
                }
                  
              } else {
                  if (y < finY) {
                    y++;
                  }else{
                    y--;
                  }
              }

        laberinto[y][x] = 1;

        generarCaminoAleatorio(laberinto, finX, finY, x, y);
    }

void generarCaminoTrampa(int[][] laberinto, int n, int finX, int finY, int caminosTrampa, int j) {
  if (j < caminosTrampa) {
    int x = int(random(n));
    int y = int(random(n));

    while (x == finX && y == finY) {
      x = int(random(n));
      y = int(random(n));
    }

    for (int i = 0; i < n; i++) {
      laberinto[y][x] = 1;

      int direccion = int(random(4));

      switch (direccion) {
        case 0:
          y = max(0, y - 1);
          break;
        case 1:
          y = min(n - 1, y + 1);
          break;
        case 2:
          x = max(0, x - 1);
          break;
        case 3:
          x = min(n - 1, x + 1);
          break;
      }
    }
    generarCaminoTrampa(laberinto, n, finX, finY, caminosTrampa, j + 1);
  }
}

    static boolean validarTamaño(int n) {
        return n >= 2;
    }

    static boolean validarCoordenadas(int coord, int n) {
        return coord == 0 || coord == n - 1;
    }
