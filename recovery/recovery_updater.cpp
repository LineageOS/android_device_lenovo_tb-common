/*
 * Copyright (C) 2015, The CyanogenMod Project
 * Copyright (C) 2018, The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "edify/expr.h"
#include "otautil/error_code.h"
#include "updater/install.h"

/* lenovo.file_exists("PATH") */
Value * FileExistsFn(const char *name, State *state, const std::vector<std::unique_ptr<Expr>>& argv) {
    struct stat buffer;
    std::vector<std::string> file_path;
    if (!ReadArgs(state, argv, &file_path)) {
        return ErrorAbort(state, kArgsParsingFailure, "%s() error parsing arguments", name);
    }
    return StringValue((stat(file_path[0].c_str(), &buffer) == 0) ? "1" : "0");
}

void Register_librecovery_updater_lenovo() {
    RegisterFunction("lenovo.file_exists", FileExistsFn);
}
