# Wembley Studios Movies (weApp)

Aplicación desarrollada en Flutter para la gestión de películas favoritas de los empleados de Wembley Studios.

## Funcionamiento

El sistema obtiene las películas de la API de *The Movie DB*: https://www.themoviedb.org/documentation/api?language=es-ES

La siguiente ilustración corresponde con el diagrama de estados de la aplicación.

![](https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/diagram.png)

El patrón de diseño seguido ha sido **Model View View-Model (MVVM)**, en la cual hemos incorporado la funcionalidad de **Provider** para manejar los estados de la app.

Se ha creado un único ViewModel para la gestión de la funcionalidad inherente a la entidad **Movie**.

La obtención de los datos, tanto de las películas populares como las buscadas por el usuario, se llevará a cabo gracias a un **stream** que comunica el View con el ViewModel de la entidad Movie. En el caso de interactuar con la aplicación al darle al botón de siguiente página, o la búsqueda, implica que el stream seguirá actualizándose. 

En torno a la lógica de los likes, para la **persistencia** de las películas seleccionadas como favoritas se ha creado una base de datos con *SQLite*. Al iniciar la app, se realiza un volcado de la base de datos a la caché. De esta forma, el usuario tendrá en todo momento disponible su lista de películas favoritas.

## Vídeos de prueba

En este fragmento podemos comprobar el funcionamiento de la lista de películas populares obtenidas por la API correspondiente. Incluso el cambio de página con el botón de ADD.


![](https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/1.gif)


En este fragmento podemos comprobar el funcionamiento del sistema de likes de la app.


![](https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/2.gif)


En este fragmento podemos comprobar el funcionamiento del search bar.


![](https://github.com/carlosparra1998/WembleyStudiosMovies/blob/main/readme_raw/3.gif)