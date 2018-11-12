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

// Hubiera estado piola que estuvieran los pedidos dentro de la
// Sucursal.
class Sucursal {
	const property minimoParaDescuento
}

// Reiterando lo anterior, pedidos hubiese estado bueno que estuviera
// en sucursal, aca se te facilito en algunos casos y complico en otros. 
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
	
	// aca confundiste el mensaje sum con el mensaje count
	// sum evalua numeros y count booleanos.
	method pedidosPorColor(color){
		return pedidos.sum({ped => ped.modeloRemera().color() == color})
	}
	method pedidoMasCaro(){
		return pedidos.max({ped => ped.precio()})
	}
	
	method tallesPedidos() {
		return pedidos.map({ped => ped.talle()})
	}
	
	// OJO: los rangos son objetos inmutables, osea solo tiene constantes
	// ademas, no contiene ese metodo la calse Rango.
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
