#include <stdio.h>
#include <chrono>
#include "tensorflow/lite/interpreter.h"
#include "tensorflow/lite/kernels/register.h"
#include "tensorflow/lite/model.h"
#include "tensorflow/lite/tools/gen_op_registration.h"
#include <iostream>

int main(){

    std::unique_ptr<tflite::FlatBufferModel> model = tflite::FlatBufferModel::BuildFromFile("linear.tflite");

    if(!model){
        printf("Failed to mmap model\n");
        exit(0);
    }

    tflite::ops::builtin::BuiltinOpResolver resolver;
    std::unique_ptr<tflite::Interpreter> interpreter;
    tflite::InterpreterBuilder(*model.get(), resolver)(&interpreter);

    // Resize input tensors, if desired.
    interpreter->AllocateTensors();

    float* input = interpreter->typed_input_tensor<float>(0);
    // Dummy input for testing
    *input = 20.0;

    const std::vector<int> inputs = interpreter->inputs();
    const std::vector<int> outputs = interpreter->outputs();

    std::cout << "input " <<  inputs[0] << "\r\n";
    std::cout << "number of inputs " <<  interpreter->inputs().size() <<"\r\n";
    std::cout << "number of outputs " << interpreter->outputs().size() << "\r\n";
    std::cout << "input(0) name: " <<  interpreter->GetInputName(0) << "\r\n";
    std::cout << "output(0) name: " << interpreter->GetOutputName(0) << "\r\n";

    int t_size = interpreter->tensors_size();
    for ( int i = 0; i < t_size; i++)
    {
	if (interpreter-> tensor(i)->name)
          {
		std::cout << i << ":  " << interpreter->tensor(i) ->name << ", "
                          << interpreter->tensor(i)->bytes << " ,  "
                          << interpreter->tensor(i)->type << ".  "
                          << interpreter->tensor(i)->params.scale << ",  "
                          << interpreter->tensor(i)->params.zero_point << "\r\n";
          }
    }


// Measure latency
    int numTests{10000};
    std::chrono::steady_clock::time_point begin =
        std::chrono::steady_clock::now();
    for (int i = 0; i < numTests; i++)
    {
         interpreter->Invoke();
    }
    std::chrono::steady_clock::time_point end =
        std::chrono::steady_clock::now();
    std::cout << "Minimum Inference Latency: "
              << std::chrono::duration_cast<std::chrono::milliseconds>(end -
                                                                       begin)
                         .count() /
                     static_cast<float>(numTests)
              << " ms" << std::endl;

    

    float* output = interpreter->typed_output_tensor<float>(0);

    printf("Result is: %f\n", *output);

    return 0;

}
