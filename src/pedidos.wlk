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
			return self.precioBase() - (self.precioBase()) * (modeloRemera.porcentajeDescuento() / 100)
		}
		else {
			return self.precioBase()
		}
	}
}

class Sucursal {
	const property minimoParaDescuento
}

class Comercio {
	var property pedidos = []
	method registrarPedido(pedido){
		pedidos.add(pedido)
	}
	method totalFacturado(){
		return pedidos.sum({ped => ped.precio()})
	}
	method pedidosPorSucursal(sucursal){
		return pedidos.filter({ped => ped.sucursal() == sucursal})
	}
	method totalPorSucursal(sucursal){
		 return self.pedidosPorSucursal(sucursal).sum({ped => ped.precio()})
	}
	method pedidosPorColor(color){
		return pedidos.sum({ped => ped.modeloRemera().color() == color})
	}
	method pedidoMasCaro(){
		return pedidos.max({ped => ped.precio()})
	}
	
	method tallesPedidos() {
		return pedidos.map({ped => ped.talle()})
	}
	method tallesNoPedidos() {
		var a = new Range(32, 48)
		return a.removeAllSuchThat({num => self.tallesPedidos().contains(num)})
	}
	method sucursalesQuePidieron(){
		return pedidos.filter({ped => ped.sucursal()})
	}

	method sucursalQueMasFacturo(){
		return self.sucursalesQuePidieron().max({sucursal => self.totalPorSucursal(sucursal)})
	}
	
	
}
