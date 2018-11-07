import remeras.*



class Pedido {
	var property sucursal //objeto de clase sucursal
	var property cantidad
	var property modeloRemera // Nuevo objeto que hereda remera
	
	method precioBase() {
		return modeloRemera.precio() * cantidad
	}
	method aplicaDescuento() {
		return cantidad >= sucursal.minimoParaDescuento()
	}
	
	method precio() {
		if (self.aplicaDescuento()){
			return self.precioBase() * modeloRemera.porcentajeDescuento() / 100
		}
		else {
			return self.precioBase()
		}
	}
}

class Sucursal {
	const property minimoParaDescuento
}

