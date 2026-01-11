import zipfile
import os
import sys

def extract_flutter():
    zip_path = r"D:\study\sms-group\flutter_windows_3.16.5-stable.zip"
    extract_path = r"C:"

    print(f"正在解压 Flutter SDK...")
    print(f"源文件: {zip_path}")
    print(f"目标目录: {extract_path}")
    print()

    # 检查文件是否存在
    if not os.path.exists(zip_path):
        print(f"错误: 文件不存在 - {zip_path}")
        return False

    # 删除现有安装
    flutter_dir = os.path.join(extract_path, "flutter")
    if os.path.exists(flutter_dir):
        print("删除现有 Flutter 安装...")
        import shutil
        shutil.rmtree(flutter_dir)

    # 解压文件
    try:
        print("开始解压...")
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_path)
        print("解压完成！")
    except Exception as e:
        print(f"解压失败: {e}")
        return False

    # 检查是否成功
    flutter_exe = os.path.join(flutter_dir, "bin", "flutter.exe")
    if os.path.exists(flutter_exe):
        print()
        print("=" * 50)
        print("Flutter SDK 解压成功！")
        print("=" * 50)
        print(f"安装位置: {flutter_dir}")
        print()
        return True
    else:
        print("解压验证失败")
        return False

if __name__ == "__main__":
    success = extract_flutter()
    if success:
        print("准备配置环境变量...")
    else:
        print("安装失败，请检查错误信息")
        sys.exit(1)

    input("按回车键退出...")