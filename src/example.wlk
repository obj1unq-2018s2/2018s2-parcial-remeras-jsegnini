/** First Wollok example */
class Remera {
	const property talle //Valor entre 32 y 48
	const property color //Definido por metodos de objeto colores
	
	method esTalleChico() {return talle >= 32 and talle <= 40 }
	method esTalleGrande() {return talle >= 41 and talle <= 48}
	method esColorBasico() {
		return color == colores.blanco() or
		color == colores.negro() or
		color == colores.gris()
	}
	method precioTalleChico() {return 80}
	method precioTalleGrande() {return 100}
	
	method precioPorTalle() {
		if (self.esTalleChico()) {
			return self.precioTalleChico()
		}
		else {
			return self.precioTalleGrande()
		}
	}
}

object colores {
	method blanco() {return "blanco"}
	method negro() {return "negro"}
	method gris() {return "gris"}
}

class Lisa inherits Remera {
	method precio() {
		if (self.esColorBasico()){
			return self.precioPorTalle()
		}
		else {
			return self.precioPorTalle() * 0.10
		}
	}
}

class Bordada inherits Lisa {
	var property cantColores // numero
	
	override method precio(){
		return super() + (cantColores * 10).max(20)
	}
}

class Sublimada inherits Lisa {
	var property anchoSublimado
	var property altoSublimado
	var property duenioDibujo //instancia de objeto empresas
	
	method precioExtra() {
		if (duenioDibujo != null) {
			return duenioDibujo
		}
		else {
			return 0
		}
	}
	
	override method precio() {
		return super() + (anchoSublimado * altoSublimado * 0.5) + self.precioExtra()
	}
}

object empresas {
	var property disney = 100
}