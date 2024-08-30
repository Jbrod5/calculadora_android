package com.jbrod.calculadoracompi.calculadora

import android.content.Intent
import android.os.Bundle
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.jbrod.calculadoracompi.R
import com.jbrod.calculadoracompi.analizadores.Lexer
import com.jbrod.calculadoracompi.analizadores.Parser
import java.io.StringReader

class Inicio : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_inicio)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        val etOperaciones = findViewById<EditText>(R.id.etOperaciones)
        val btnCompilar = findViewById<AppCompatButton>(R.id.btnCompilar)

        btnCompilar.setOnClickListener{

            var resultado: String = ""

            var reader = StringReader(resultado)
            var lexer = Lexer(reader)
            var parser = Parser(lexer)
            parser.parse()

            resultado = parser.obtenerResultado()

            val intent = Intent(this, Resultado::class.java)
            intent.putExtra("RESULTADO", resultado)
            startActivity(intent)

        }
    }


}