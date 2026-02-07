#include "llvm/IR/Function.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

void countBinaryOps(Function &F) { 
    int count = 0;
    for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
            if (auto *binOp = dyn_cast<BinaryOperator>(&I)) {
                count++;
                errs() << "Found binary operation: " << binOp->getOpcodeName() << "\n";
            }
        }
    }
    errs() << "函数 " << F.getName() << " 中共有 " << count << " 个二进制运算指令。\n";
}

int main() {
    LLVMContext Context;
    Module *M = new Module("test", Context);
    Function *F = Function::Create(FunctionType::get(IntegerType::getInt32Ty(Context), false), Function::ExternalLinkage, "main", M);
    BasicBlock *BB = BasicBlock::Create(Context, "entry", F);
    BinaryOperator::CreateAdd(
        ConstantInt::get(IntegerType::getInt32Ty(Context), 1),
        ConstantInt::get(IntegerType::getInt32Ty(Context), 2),
        "sum", BB);
    ReturnInst::Create(Context, ConstantInt::get(IntegerType::getInt32Ty(Context), 0), BB);
    countBinaryOps(*F);
    return 0;
}
