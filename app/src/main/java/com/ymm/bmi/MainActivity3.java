package com.ymm.bmi;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity3 extends AppCompatActivity {
Button b2;
TextView logIn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);

        logIn =findViewById(R.id.Login_tv_ac2);
    b2 =findViewById(R.id.b_creatacc);
        logIn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {

            Intent intent =new Intent(getBaseContext(),MainActivity2.class);

            startActivity(intent);

        }
    });
        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent =new Intent(getBaseContext(),MainActivity4.class);

                startActivity(intent);

            }
        });

    }
}