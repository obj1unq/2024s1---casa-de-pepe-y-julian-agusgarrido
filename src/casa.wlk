object casaDePepeYJulian {

	var property viveres = 50
	var property reparaciones = 0
	var property cuenta = cuentaCombinada
	var property estrategiaDeAhorro = full

	method hayViveresSuficientes() {
		return viveres > 40
	}

	method hayReparacionesPorHacer() {
		return reparaciones > 0
	}

	method casaEnOrden() {
		return self.hayViveresSuficientes() and not self.hayReparacionesPorHacer()
	}

	method nuevaReparacion(costo) {
		reparaciones += costo
	}

	method reparar() {
		cuenta.extraer(reparaciones)
		reparaciones = 0
	}

	method puedePagarReparaciones() {
		return cuenta.saldo() >= reparaciones
	}

	method sobranteAlReparar() {
		return cuenta.saldo() - reparaciones
	}

	method comprarViveres(porcentaje, calidad) {
		viveres += porcentaje
		cuenta.extraer(porcentaje * calidad)
	}

	method mantener() {
		estrategiaDeAhorro.mantener(self)
	}

}

object cuentaCorriente {

	var property saldo = 0

	method depositar(cantidad) {
		saldo += cantidad
	}

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaConGastos {

	var property saldo = 0
	var property costoOperativo = 20

	method depositar(cantidad) {
		saldo += cantidad - costoOperativo
	}

	method extraer(cantidad) {
		saldo -= cantidad
	}

}

object cuentaCombinada {

	var property cuentaPrimaria = cuentaConGastos
	var property cuentaSecundaria = cuentaCorriente

	method saldo() {
		return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
	}

	method depositar(cantidad) {
		cuentaPrimaria.depositar(cantidad)
	}

	method extraer(cantidad) {
		if (cuentaPrimaria.saldo() > cantidad) {
			cuentaPrimaria.extraer(cantidad)
		} else {
			cuentaSecundaria.extraer(cantidad)
		}
	}

}

object minimoIndispensable {

	const calidad = 3

	method mantener(casa) {
		if (not casa.hayViveresSuficientes()) {
			const viveresFaltantes = 40 - casa.viveres()
			casa.comprarViveres(viveresFaltantes, calidad)
		}
	}

}

object full {

	const calidad = 5

	method mantener(casa) {
		var viveresAComprar = 0
		if (casa.casaEnOrden()) {
			viveresAComprar = 100 - casa.viveres()
		} else {
			viveresAComprar = 40
		}
		casa.comprarViveres(viveresAComprar, calidad)
		if (casa.puedePagarReparaciones() && casa.sobranteAlReparar() >= 1000) {
			casa.reparar()
		}
	}

}

/*PREGUNTA FINAL
 * Si, se puede modelar otra casa para este ejercicio.
 * En caso de hacerlo, la casa debe entender los mismos mensajes
 * de casaDePepeYJulian:
 * * hayViveresSuficientes()
 * * hayReparacionesPorHacer()
 * * casaEnOrden()
 * * nuevaReparacion()
 * * reparar()
 * * puedePagarReparacion()
 * * sobranteAlReparar()
 * * comprarViveres()
 * * mantener()
 * * Además, los getters y setters de los atributos.
 */
