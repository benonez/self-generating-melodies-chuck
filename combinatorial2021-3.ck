188 => int target;
187 => int target2;
8 => int reps;
int i_prev, j_prev, k_prev, i_prev2, j_prev2, k_prev2, count, count2, temp, temp2;
120 => float enterBPM; <<<"Tempo: ", enterBPM >>>;
16 => float division; <<<"Divide: ", division >>>;
( 1.0 / enterBPM ) * ( 60.0 / division ) * (second/samp) => float T;
[1,1,2,2,2,1,1,2,1,1,2] @=> int talea[];
[1,1,2,2,2,1,1,2,2,1,1] @=> int talea2[];
0 => int num_count;
for(0 => int i;i<talea.size();i++) num_count + talea[i] => num_count;
<<< num_count >>>;
0 => num_count;
for(0 => int i;i<talea2.size();i++) num_count + talea2[i] => num_count;
<<< num_count >>>;
1 => int device;
if( me.args() ) me.arg( 0 ) => Std.atoi => device;
MidiOut mout;  MidiMsg msg, msg2;
if( !mout.open( device ) ) me.exit();
<<< "MIDI device in:", mout.num(), " -> ", mout.name() >>>;
fun void fun1(){
    for(0 => int l2; l2<reps; l2++){
        for(0 => int k2; k2<127; k2++){
            for(0 => int j2; j2<127; j2++){
                for(0 => int i2; i2<127; i2++){
                    i2+j2+k2 => temp2;
                    if(temp2==target2+l2){
                        if(i2%12==0||i2%12==2||i2%12==3|k2%12==7){
                            if(j2%12==0||j2%12==2||j2%12==7||j2%12==8){
                                if(k2%12==0||k2%12==3||k2%12==5|k2%12==8){
                                    129 => msg2.data1;
                                    i_prev2 => msg2.data2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    129 => msg2.data1;
                                    j_prev2 => msg2.data2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    129 => msg2.data1;
                                    k_prev2 => msg2.data2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    145 => msg2.data1;
                                    i2 => msg2.data2 => i_prev2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    145 => msg2.data1;
                                    j2 => msg2.data2 => j_prev2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    145 => msg2.data1;
                                    k2 => msg2.data2 => k_prev2;
                                    127 => msg2.data3;
                                    mout.send( msg2 );
                                    (T*talea2[count2])::samp => now;
                                    (count2+1) % talea2.size() => count2;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
spork ~ fun1();
for(0 => int l; l<reps; l++){
    for(0 => int k; k<127; k++){
        for(0 => int j; j<127; j++){
            for(0 => int i; i<127; i++){
                i+j+k => temp;
                if(temp==target+l){
                    if(i%12==0||i%12==2||i%12==7||k%12==8){
                        if(j%12==0||j%12==3||j%12==5||j%12==7){
                            if(k%12==0||k%12==3||k%12==7||k%12==10){
                                128 => msg.data1;
                                i_prev => msg.data2;
                                127 => msg.data3;
                                mout.send( msg );
                                128 => msg.data1;
                                j_prev => msg.data2;
                                127 => msg.data3;
                                mout.send( msg );
                                128 => msg.data1;
                                k_prev => msg.data2;
                                127 => msg.data3;
                                mout.send( msg );
                                144 => msg.data1;
                                i => msg.data2 => i_prev;
                                127 => msg.data3;
                                mout.send( msg );
                                144 => msg.data1;
                                j => msg.data2 => j_prev;
                                127 => msg.data3;
                                mout.send( msg );
                                144 => msg.data1;
                                k => msg.data2 => k_prev;
                                127 => msg.data3;
                                mout.send( msg );
                                (T*talea[count])::samp => now;
                                (count+1) % talea.size() => count;
                            }
                        }
                    }
                }
            }
        }
    }
}