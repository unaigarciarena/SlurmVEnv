1- Creo el entorno en el nodo pruebas e instalo todas las librerías. Es mejor hacerlo en el pruebas que en el ordenador de cada uno porque el sistema en todos los nodos es el mismo, y si funciona en el pruebas, funciona en todos.

2- Creo un zip con el entorno.

3- Con el SendCC borro cualquier cosa que haya en mis carpetas temporales. Aquí suelo tener mi entorno virtual y posible basura de ejecuciones anteriores. Estas tareas también copian y descomprimen los entornos en cada nodo. Esto no es óptimo, ya que estás dejando ~1gb en cada nodo, pero creo que es la mejor opción.

4- Mando los trabajos con el script normal (te mando el ejemplo de lanzar...sh), activando y desactivando el entorno desde donde lo habían puesto las tareas anteriores.

Puede pasar (de hecho, pasa habitualmente) que un nodo tenga todos sus hilos ocupados, y no pueda entrar la tarea de copiar el entorno virtual.  

En ese caso, puede ser que se libren varias tareas en ese nodo a la vez, y entren al mismo tiempo la tarea que copia el entorno virtual y las tareas que quieres ejecutar. Como el entorno tarda en copiarse, la tarea que quieres ejecutar intenta leerlo antes de que esté, por lo que da error. Para eso tengo el nodelist.sh, que lo que hace es leer los outputs que han generado las tareas de copiar el entorno. 

El output de este script es otro script, cuyo output es una línea del estilo --exclude nodox1,nodox2...nodox2. Los nodos nodoxn son los nodos de los que no se ha recibido confirmación de que el entorno se haya copiado. Pasándole esto como flag al sbatch evitas que ningún trabajo entre a ese nodo que no tiene el entorno virtual.

Estoy seguro que hay muchas maneras mejores de hacerlo, pero yo he llegado a este punto, es bastante rápido de hacer, y en caso de que no necesites ninguna librería nueva, ni siquiera necesitas recopiar los entornos, porque ya los tienes en los nodos, sólo tienes que mirar en qué nodos está con el nodelist.sh, y mandar las tareas normal.

Se aceptan mejoras y críticas. Unlikely que las críticas terminen siendo mejoras, así que las mejoras se aceptan más que las críticas.
