# LiteGPO
LiteGPO permite ejecutar GPOs de forma remota usando una comunicación directa entre ordenadores o centralizada con servidor Linux. Por tanto no requiere la adquisición de licencias de Windows Server ni el despliegue de un Directorio Activo, sin por ello perder la capacidad de centralizar y controlar todo aquello que se puede hacer en una red DA. Sería por tanto un Directorio Activo para GPOs destinado a instalaciones pequeñas o a empresas que no pueden permitirse pagar una licencia de servidor Windows. 

LiteGPO también es útil para implementar funcionalidades específicas en máquinas de la red que por alguna razón no han capturado bien una GPO general o que necesitan características muy específicas que la primera no puede garantizar.

LiteGPO no implementa por si solo otras características habituales de DA como por ejemplo la autenticación de usuarios y por tanto no constituye un sustituto del Directorio Activo de Microsoft.

Existen tres tipos básicos de LiteGPO. 

# El primero es LiteGPO punto-a-punto:

Permite instalar en una relación 1 a 1 un script Power Shell desde una máquina cualquiera de la red en otra máquina remota de la cual se cuenta con visibilidad y credenciales suficientes. Permite contra-GPOs o comunicarse con máquinas fuera del DA.

# El segundo es LiteGPO centralizado: 

Permite desplegar scripts desde un servidor Linux de forma centralizada y simultánea, tanto en tiempo real como en ventana de oportunidad (cuando el usuario se conecte).

Para que LiteGPO, (tanto centralizado como punto-a-punto), funcione es preciso instalar y habilitar SSH en el ordenador remoto y disponer de un servidor Linux.

Los scripts que se vayan introduciendo son en en su mayoría para LiteGPO punto-a-punto. Cuando sean aptos para servidores, se indicarán de forma clara en el nombre mismo del script empleando el prefijo "server".

# El tercero es LiteGPO punto-a-multipunto:

Aquí ya no es necesario disponer de un servidor, ni Linux ni Windows. Una de las máquinas (cualquier Windows 10/11 sirve) se erige como orquestador, aplicando la política pertinente en todos los dispositivos sobre los que tenga visión en su VLAN. Lógicamente, si la máquina pertenece a un usuario, su disponibilidad es menor que en el modelo de LiteGPO centralizado.
